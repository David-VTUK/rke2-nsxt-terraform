variable "vm_template_name" {
  type        = string
  description = "Name of the VM template used to create the RKE2 cluster"
}

variable "vm_template_num_cpu" {
  type        = number
  description = "Number of vCPU's to allocate to each RKE2 node VM"
}

variable "vm_template_disk_size" {
  type        = number
  description = "Size (in GB) of the root disk for the RKE2 node VM"
}

variable "vm_mem_size" {
  type        = number
  description = "Size (in GB) of the amount of RAM allocated to the RKE2 VM"
}

variable "vm_datastore" {
  type        = string
  description = "Destination datastore for the RKE2 node VM"
}

variable "vm_compute_cluster" {
  type        = string
  description = "vSphere cluster for the VM to reside in"
}

variable "vm_datacenter" {
  type        = string
  description = "vSphere datacenter for the VM to reside in"
}

variable "vm_guestid" {
  type        = string
  description = "Guest ID of the VM. IE ubuntu64Guest"
}

variable "management_segment_id" {
  type        = string
  description = "Reference to the management logical switch"
}


variable "nsxt_management_network_name" {
  type        = string
  description = "Network name used for management network segment"
}

variable "nsxt_overlay_network_name" {
  type        = string
  description = "Network name used for overlay network segment"
}

variable "nsxt_overlay_network_path" {
  type        = string
  description = "Network name used for overlay network segment"
}

variable "nsxt_management_network_path" {
  type        = string
  description = "Network name used for management network segment"
}

variable "k8s_clustername" {
  type        = string
  description = "Name of the cluster used for tagging"
}

variable "k8s_clusterversion" {
  type        = string
  description = "Version of k8s to install. IE v1.22.10+rke2r2"
}

variable "k8s_nodename" {
  type        = string
  description = "Name of the node"
}

# K8s specific variables


variable "k8s_ovs_uplink_port" {
  type        = string
  description = "Name of the interface used for overlay traffic"
}
variable "k8s_apiserver_host_port" {
  type        = string
  description = "Port number access the API server. Can either be a LB-fronted IP or one of the node IPs"
}


variable "k8s_ncp_image_location" {
  type        = string
  description = "Image tag for the NCP container image"
}

variable "nsxt_api" {
  type        = string
  description = "IP or FQDN of the NSX manager or VIP"
}

variable "nsxt_username" {
  type        = string
  description = "Username for NSX-T API Calls"
}

variable "nsxt_password" {
  type        = string
  description = "Password for the account referenced in nsxt_username"
}

variable "nsxt_insecure" {
  type        = bool
  description = "Enable to bypass TLS checks against the NSX Manager"
}

variable "nsxt_container_ipblocks_name" {
  type        = string
  description = "Name of the IP address block used for container networking"
  default     = "IB_K8S_PODS"
}

variable "nsxt_external_ip_pools_lb_name" {
  type        = string
  description = "Name of the IP Poolk used to allocate IP addresses to LB services"
  default     = "IP_K8S_LB"
}

variable "nsxt_t0_router" {
  type        = string
  description = "Name or ID for the T0 Router"
}

variable "nsxt_overlay_tz" {
  type        = string
  description = "Name or ID of the NSX overlay transport zone"
}

variable "nsx_policy_top_ID" {
  type        = string
  description = "ID of the top firewall policy object"
}

variable "nsx_policy_bottom_ID" {
  type        = string
  description = "ID of the bottom firewall policy object"
}

variable "nsxt_management_network" {
  type        = string
  description = "Network used for management network segment"
  default     = "172.16.110.0"
}

variable "nsxt_management_mask" {
  type        = string
  description = "Subnet mask used for management network segment"
  default     = "24"
}

variable "nsxt_overlay_network" {
  type        = string
  description = "Network used for overlay network segment"
  default     = "172.16.111.0"
}

variable "nsxt_overlay_mask" {
  type        = string
  description = "Subnet mask used for overlay network segment"
  default     = "24"
}