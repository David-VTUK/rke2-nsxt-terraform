# NSX-T specific variables

variable "nsxt_t0_router" {
  type        = string
  description = "Name or ID for the T0 Router"
}

variable "nsxt_edgecluster" {
  type        = string
  description = "Name of the edge cluster"
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

variable "nsxt_overlay_tz" {
  type        = string
  description = "Name or ID of the NSX overlay transport zone"
}

variable "nsxt_container_ipblocks" {
  type        = string
  description = "CIDR block used to allocate IP addresses to Pods"
  default     = "172.150.0.0/16"
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


variable "nsxt_external_ip_pools_lb" {
  type        = string
  description = "IP Pool to allocate external IP addresses from"
  default = "10.100.100.0/24"
}

variable "nsxt_overlay_network" {
  type        = string
  description = "Network used for overlay network segment"
  default     = "172.16.110.0"
}

variable "nsxt_overlay_mask" {
  type        = string
  description = "Subnet mask used for overlay network segment"
  default     = "24"
}

variable "nsxt_management_network" {
  type        = string
  description = "Network used for management network segment"
  default     = "172.16.111.0"
}

variable "nsxt_management_mask" {
  type        = string
  description = "Subnet mask used for management network segment"
  default     = "24"
}