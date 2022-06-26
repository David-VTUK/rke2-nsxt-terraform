provider "vsphere" {
  user = var.vsphere_user
  password = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

provider "nsxt" {
    username = var.nsxt_username
    password = var.nsxt_password
    host = var.nsxt_api
    allow_unverified_ssl = true    
}

provider "rancher2" {
    api_url    = var.rancher2_baseurl
  access_key = var.rancher2_access_key
  secret_key = var.rancher2_secret_key
}


module "nsxt" {
  source = "./modules/nsxt"

  nsxt_t0_router            = var.nsxt_t0_router
  nsxt_edgecluster          = var.nsxt_edgecluster
  nsxt_api                  = var.nsxt_api
  nsxt_username             = var.nsxt_username
  nsxt_password             = var.nsxt_password
  nsxt_overlay_tz           = var.nsxt_overlay_tz
  nsxt_container_ipblocks   = var.nsxt_container_ipblocks
  nsxt_external_ip_pools_lb = var.nsxt_external_ip_pools_lb
  nsxt_overlay_network_name = var.nsxt_overlay_network_name
  nsxt_management_network_name = var.nsxt_management_network_name
 
}

module "vsphere" {
  source = "./modules/vSphere"

/*
  vsphere_user = var.vsphere_user
  vsphere_password = var.vsphere_password
  vsphere_server = var.vsphere_server
  overlay_segment_id = module.nsxt.overlay_segment_id
  */

  management_segment_id = module.nsxt.management_segment_id

  nsxt_management_network_name = module.nsxt.management_segment_name
  nsxt_overlay_network_name = module.nsxt.overlay_segment_name

//  nsxt_overlay_network_name = var.nsxt_overlay_network_name

  nsxt_management_network_path = module.nsxt.management_segment_path
  nsxt_overlay_network_path = module.nsxt.overlay_segment_path

  k8s_clustername = var.k8s_clustername
  k8s_nodename = var.k8s_nodename

    nsxt_insecure = var.nsxt_insecure
  nsx_policy_top_ID = module.nsxt.policy_top_ID
  nsx_policy_bottom_ID = module.nsxt.policy_bottom_ID
  nsxt_overlay_tz = var.nsxt_overlay_tz
  nsxt_container_ipblocks_name = var.nsxt_container_ipblocks_name
  nsxt_external_ip_pools_lb_name = var.nsxt_external_ip_pools_lb_name
  nsxt_username = var.nsxt_username
  nsxt_api = var.nsxt_api
  nsxt_password = var.nsxt_password
  nsxt_t0_router = var.nsxt_t0_router
  k8s_apiserver_host_port = "6443"
  k8s_ovs_uplink_port = var.k8s_ovs_uplink_port
  k8s_ncp_image_location = var.k8s_ncp_image_location
}

