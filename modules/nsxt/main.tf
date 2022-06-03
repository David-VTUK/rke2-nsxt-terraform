data "nsxt_policy_transport_zone" "overlay_tz" {
  display_name = var.nsxt_overlay_tz

}

data "nsxt_policy_edge_cluster" "edgecluster" {
  display_name = var.nsxt_edgecluster

}

data "nsxt_policy_tier0_gateway" "t0" {
  display_name = var.nsxt_t0_router

}


resource "nsxt_policy_tier1_gateway" "tier1_gw" {
  description               = "Tier-1 provisioned by Terraform"
  display_name              = "Tier1-gw1"
  nsx_id                    = "predefined_id"
  edge_cluster_path         = data.nsxt_policy_edge_cluster.edgecluster.path
  failover_mode             = "PREEMPTIVE"
  default_rule_logging      = "false"
  enable_firewall           = "true"
  enable_standby_relocation = "false"
  tier0_path                = data.nsxt_policy_tier0_gateway.t0.path
  route_advertisement_types = ["TIER1_STATIC_ROUTES", "TIER1_CONNECTED"]
  pool_allocation           = "ROUTING"
}

resource "nsxt_policy_dhcp_server" "overlay-dhcp-server" {
  display_name      = "DHCP server for Overlay"
  edge_cluster_path = data.nsxt_policy_edge_cluster.edgecluster.path
  server_addresses  = [join("", [cidrhost("${var.nsxt_overlay_network}/${var.nsxt_overlay_mask}", 2), "/", var.nsxt_overlay_mask])]
}

resource "nsxt_policy_dhcp_server" "management-dhcp-server" {
  display_name      = "DHCP server for Management"
  edge_cluster_path = data.nsxt_policy_edge_cluster.edgecluster.path
  server_addresses  = [join("", [cidrhost("${var.nsxt_management_network}/${var.nsxt_management_mask}", 2), "/", var.nsxt_management_mask])]
}


resource "nsxt_policy_segment" "overlay-segment" {
  display_name        = "overlay-segment"
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  dhcp_config_path    = nsxt_policy_dhcp_server.overlay-dhcp-server.path

  subnet {
    cidr = join("", [cidrhost("${var.nsxt_overlay_network}/${var.nsxt_overlay_mask}", 1), "/", var.nsxt_overlay_mask])

    dhcp_ranges = [join("", [cidrhost("${var.nsxt_overlay_network}/${var.nsxt_overlay_mask}", 100), "-", cidrhost("${var.nsxt_overlay_network}/${var.nsxt_overlay_mask}", 200)])]

    dhcp_v4_config {
      server_address = nsxt_policy_dhcp_server.overlay-dhcp-server.server_addresses[0]
      dns_servers    = ["192.168.1.208"]
    }
  }
}



resource "nsxt_policy_segment" "management-segment" {
  display_name        = "management-segment"
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  dhcp_config_path    = nsxt_policy_dhcp_server.management-dhcp-server.path
  connectivity_path   = nsxt_policy_tier1_gateway.tier1_gw.path

  subnet {
    cidr = join("", [cidrhost("${var.nsxt_management_network}/${var.nsxt_management_mask}", 1), "/", var.nsxt_management_mask])

    dhcp_ranges = [join("", [cidrhost("${var.nsxt_management_network}/${var.nsxt_management_mask}", 100), "-", cidrhost("${var.nsxt_management_network}/${var.nsxt_management_mask}", 200)])]

    dhcp_v4_config {
      server_address = nsxt_policy_dhcp_server.management-dhcp-server.server_addresses[0]
      dns_servers    = ["192.168.1.208"]
    }
  }
}

resource "nsxt_policy_security_policy" "policy-top" {
  display_name = "k8s_nsxt_top"
  category = "Application"
}

resource "nsxt_policy_security_policy" "policy-bottom" {
  display_name = "k8s_nsxt_bottom"
    category = "Application"
}

resource "nsxt_policy_ip_block" "container_ipblock" {
  display_name = var.nsxt_container_ipblocks_name
  cidr = var.nsxt_container_ipblocks
}



resource "nsxt_policy_ip_block" "lb_ipblock" {
  display_name = var.nsxt_external_ip_pools_lb_name
  cidr = var.nsxt_external_ip_pools_lb
}

resource "nsxt_policy_ip_pool" "lb_ippool" {
  display_name = var.nsxt_external_ip_pools_lb_name
}

resource "nsxt_policy_ip_pool_block_subnet" "lb_ip_blocksubnet" {
  display_name        = var.nsxt_external_ip_pools_lb_name
  pool_path           = nsxt_policy_ip_pool.lb_ippool.path
  block_path          = nsxt_policy_ip_block.lb_ipblock.path
  size                = 32
  auto_assign_gateway = false
}

