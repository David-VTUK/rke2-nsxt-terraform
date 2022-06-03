# K8s specific variables

variable "k8s_clustername" {
  type        = string
  description = "Name of the k8s cluster used for port tagging"
}
variable "k8s_ovs_uplink_port" {
  type        = string
  description = "Name of the interface used for overlay traffic"
}
variable "k8s_apiserver_host_port" {
  type        = string
  description = "Port number access the API server. Can either be a LB-fronted IP or one of the node IPs"
}

variable "k8s_apiserver_host" {
  type        = string
  description = "IP or FQDN to access the API server. Can either be a LB-fronted IP or one of the node IPs"
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
  type = string
  description = "ID of the top firewall policy object"  
}

variable "nsx_policy_bottom_ID" {
  type = string
  description = "ID of the bottom firewall policy object"  
}