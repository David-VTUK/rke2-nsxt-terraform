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
  default     = "172.100.0.0/16"
}

variable "nsxt_external_ip_pools_lb" {
  type        = string
  description = "IP Pool to allocate external IP addresses from"
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


# vSphere specific variables

variable "vsphere_user" {
  type        = string
  description = "Username for vSphere authentication"
}
variable "vsphere_password" {
  type        = string
  description = "Password for vSphere authentication"
}
variable "vsphere_server" {
  type        = string
  description = "vCenter server IP or FQDN"
}

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
  description = "IP or FQDN to access the API server. Can either be a LB-fronted IP or one of the node IPs"
}
variable "k8s_ncp_image_location" {
  type        = string
  description = "Image tag for the NCP container image"
}

# VM specific variables

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

variable "vm_datastore" {
  type        = string
  description = "Destination datastore for the RKE2 node VM"
}

variable "vm_datacenter" {
  type        = string
  description = "Name of the vSphere Datacenter object for the RKE2 node VM"
}

variable "vm_resourcepool" {
  type        = string
  description = "Name of the vSphere Resource Pool object for the RKE2 node VM"
}

variable "vm_mem_size" {
  type        = number
  description = "Size (in GB) of the amount of RAM allocated to the RKE2 VM"
}

# Rancher-specific

variable "rancher2_access_key" {
  type        = string
  description = "Access key for Rancher API access"
}

variable "rancher2_secret_key" {
  type        = string
  description = "Secret key for Rancher API access"
}

variable "rancher2_baseurl" {
  type        = string
  description = "URL for the Rancher API endpoint"
}
