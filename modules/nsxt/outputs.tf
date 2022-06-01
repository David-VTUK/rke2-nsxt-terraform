output "management-segment-name" {
  value = nsxt_policy_segment.management-segment.display_name
}

output "overlay-segment-name" {
  value = nsxt_policy_segment.overlay-segment.display_name
}

