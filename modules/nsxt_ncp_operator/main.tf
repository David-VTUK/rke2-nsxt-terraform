locals {
  template_file_operator = templatefile("${path.module}/nsx-container-plugin-operator/operator.yaml", {
    NSXT_IMAGE_LOCATION = var.k8s_ncp_image_location
  })
    template_file_configmap = templatefile("${path.module}/nsx-container-plugin-operator/configmap.yaml", {
    
        NSXT_CLUSTER_NAME = var.k8s_clustername
        K8S_SERVER_PORT = var.k8s_apiserver_host_port
        K8S_SERVER_ADDRESS = var.k8s_apiserver_host
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

resource "local_file" "operator_yaml" {
    content  = local.template_file_operator
    filename = "${path.module}/nsx-container-plugin-operator/operator.yaml"
}

resource "local_file" "configmap_yaml" {
    content  = local.template_file_configmap
    filename = "${path.module}/nsx-container-plugin-operator/configmap.yaml"
}

resource "null_resource" "cluster" {
    
    provisioner "file" {
    source      = "${path.module}/nsx-container-plugin-operator/"
    destination = "/var/lib/rancher/rke2/server/manifests/"

    connection {
        type     = "ssh"
        user     = "packerbuilt"
        password = "PackerBuilt!"
        host     = var.k8s_apiserver_host
    }
    }

      depends_on = [
    local_file.configmap_yaml,
    local_file.operator_yaml
  ]
}