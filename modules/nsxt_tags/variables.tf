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

variable "vm_name" {
  type = string
  description = "name of the VM to tag interfaces for tagging"
}

variable "k8s_clustername" {
    type = string
    description = "Name of the cluster used for tagging"
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

variable "vm_datacenter" {
  type        = string
  description = "Name of the vSphere Datacenter object for the RKE2 node VM"
}

variable "overlay_segment_path" {
  type        = string
  description = "Path of the overlay network segment to apply tags to"
}