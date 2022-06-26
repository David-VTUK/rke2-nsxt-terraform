data "vsphere_datacenter" "dc" {
  name = "Homelab"
}

data "vsphere_network" "management_network" {
  name          = var.nsxt_management_network_name
  datacenter_id = data.vsphere_datacenter.dc.id
  depends_on = [time_sleep.wait_30_seconds]
}

data "vsphere_network" "overlay_network" {
  name          = var.nsxt_overlay_network_name
  datacenter_id = data.vsphere_datacenter.dc.id
  depends_on = [time_sleep.wait_30_seconds]
}

data "vsphere_virtual_machine" "template" {
  name          = "nsxt-template-guestinfo"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "compute_cluster" {
    name = "MGMT"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
    name = "p-esxi1-nvme-1"
    datacenter_id = data.vsphere_datacenter.dc.id
  
}


resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
}

resource "vsphere_virtual_machine" "vm" {

  name             = var.k8s_nodename
  resource_pool_id = data.vsphere_compute_cluster.compute_cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 2048
  guest_id = "ubuntu64Guest"


    clone {
    template_uuid = data.vsphere_virtual_machine.template.id

  }

  network_interface {
    network_id = data.vsphere_network.management_network.id
  }

  network_interface {
    network_id = data.vsphere_network.overlay_network.id
  }

    extra_config = {

      "guestinfo.metadata.encoding" = "base64"
      "guestinfo.userdata.encoding" = "base64"

    "guestinfo.metadata" = base64encode(templatefile("${path.module}/templates/metadata.yml.tpl", {
      node_hostname = var.k8s_nodename
    }))

    "guestinfo.userdata" = base64encode(templatefile("${path.module}/templates/userdata.yml.tpl", {
      BOOTSTRAP_COMMAND = tostring(rancher2_cluster_v2.nsxt_cluster.cluster_registration_token[0].node_command)
    }))

    }

  disk {
    label = "disk0"
    size  = 50
  }
}

resource "nsxt_policy_vm_tags" "vm1_tags" {

    instance_id = vsphere_virtual_machine.vm.id

  port {
    segment_path = var.nsxt_overlay_network_path

    tag {
      scope = "ncp/node_name"
      tag = vsphere_virtual_machine.vm.name
    }
    tag {
      scope = "ncp/cluster"
      tag = var.k8s_clustername
    }

  }
}



resource "rancher2_cluster_v2" "nsxt_cluster" {
  name               = var.k8s_clustername
  kubernetes_version = "v1.22.10+rke2r2"
  rke_config {
     machine_global_config = <<EOF
      cni: none
      EOF

      additional_manifest = data.template_file.policy.rendered 
} 

}

data "template_file" "policy" {
  template = templatefile("${path.module}/templates/operator-merged.yaml", {
    NSXT_IMAGE_LOCATION = var.k8s_ncp_image_location
        NSXT_CLUSTER_NAME = var.k8s_clustername
        K8S_SERVER_PORT = var.k8s_apiserver_host_port
        K8S_SERVER_ADDRESS = "172.16.110.1"
        OVS_UPLINK_NIC = var.k8s_ovs_uplink_port
        NSXT_MANAGER_IP = var.nsxt_api
        NSXT_MANAGER_USERNAME = var.nsxt_username
        NSXT_MANAGER_PASSWORD = var.nsxt_password
        NSXT_MANAGER_INSECURE = var.nsxt_insecure
        NSXT_CONTAINER_IP_BLOCK_NAME = var.nsxt_container_ipblocks_name
        NSXT_EXTERNAL_IP_BLOCK_NAME = var.nsxt_external_ip_pools_lb_name
        NSXT_T0_NAME = var.nsxt_t0_router
        NSXT_OVERLAY_TZ_NAME = var.nsxt_overlay_tz
        NSXT_TOP_FIREWALL_ID = var.nsx_policy_top_ID
        NSXT_BOTTOM_FIREWALL_ID = var.nsx_policy_bottom_ID
    })

}
