resource "rancher2_cloud_credential" "nsxt_vsphere_credentials" {
  name = "nsxt_vsphere_credentials"
  vsphere_credential_config {
    vcenter      = var.vsphere_server
    username     = var.vsphere_user
    vcenter_port = 443
    password     = var.vsphere_password
  }

}

resource "rancher2_machine_config_v2" "vsphere-nsxt-mc" {
  generate_name = "mc-nsxt"
  vsphere_config {
    clone_from  = var.vm_template_name
    creation_type = "template"
    cpu_count   = var.vm_template_num_cpu
    datacenter  = var.vm_datacenter
    disk_size   = var.vm_template_disk_size
    memory_size = var.vm_mem_size
    datastore   = var.vm_datastore
    network     = var.vm_network_list
  }
}

resource "rancher2_cluster_v2" "nsxt_cluster" {
  name               = var.k8s_clustername
  kubernetes_version = "1.22.9+rke2r2"
  cloud_credential_secret_name = rancher2_cloud_credential.nsxt_vsphere_credentials.id
  rke_config {
    machine_pools {
      name                         = "aio"
      cloud_credential_secret_name = rancher2_cloud_credential.nsxt_vsphere_credentials.id
      control_plane_role           = true
      etcd_role                    = true
      worker_role                  = true
      quantity                     = 1
      machine_config {
        kind = rancher2_machine_config_v2.vsphere-nsxt-mc.kind
        name = rancher2_machine_config_v2.vsphere-nsxt-mc.name
      }
    }
  }

}


