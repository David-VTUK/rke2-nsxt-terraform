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
 
}


module "rancher" {
  source = "./modules/rancher"

  vsphere_user     = var.vsphere_user
  vsphere_password = var.vsphere_password
  vsphere_server   = var.vsphere_server

 k8s_clustername = var.k8s_clustername

  vm_template_name      = var.vm_template_name
  vm_template_num_cpu   = var.vm_template_num_cpu
  vm_template_disk_size = var.vm_template_disk_size
  vm_datastore          = var.vm_datastore
  vm_datacenter         = var.vm_datacenter
  vm_resourcepool       = var.vm_resourcepool
  vm_mem_size           = var.vm_mem_size
  vm_network_list       = [module.nsxt.management-segment-name, module.nsxt.overlay-segment-name]

  rancher2_access_key = var.rancher2_access_key
  rancher2_secret_key = var.rancher2_secret_key
  rancher2_baseurl    = var.rancher2_baseurl

}

module "nsxt_tags" {
  source = "./modules/nsxt_tags"

    nsxt_api = var.nsxt_api
    nsxt_username = var.nsxt_username
    nsxt_password = var.nsxt_password 

    vm_name = "${lookup(module.rancher.nsxt_cluster_node, "rke2.io/hostname" , "")}"
    
    k8s_clustername = var.k8s_clustername
    
    vsphere_user = var.vsphere_user
    vsphere_password = var.vsphere_password
    vsphere_server = var.vsphere_server
    vm_datacenter = var.vm_datacenter

    overlay_segment_path = module.nsxt.overlay_segment_path
    
}

module nsxt_ncp_operator {

 source = "./modules/nsxt_ncp_operator"

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
  k8s_apiserver_host = "${lookup(module.rancher.nsxt_cluster_node, "rke2.io/internal-ip" , "")}"
  k8s_apiserver_host_port = "6443"
  k8s_ovs_uplink_port = var.k8s_ovs_uplink_port
  k8s_ncp_image_location = var.k8s_ncp_image_location
  k8s_clustername = var.k8s_clustername
}