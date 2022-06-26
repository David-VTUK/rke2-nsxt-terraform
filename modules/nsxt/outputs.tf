output "overlay_segment_id" {
  value = nsxt_policy_segment.overlay-segment.id
}

output "management_segment_id" {
  value = nsxt_policy_segment.management-segment.id
}

output "overlay_segment_path" {
  value = nsxt_policy_segment.overlay-segment.path
}

output "management_segment_path" {
  value = nsxt_policy_segment.management-segment.nsx_id
}

output "management_segment_name" {
  value = nsxt_policy_segment.management-segment.display_name
}

output "overlay_segment_name" {
  value = nsxt_policy_segment.overlay-segment.display_name
}

output "policy_top_ID" {
  value = nsxt_policy_security_policy.policy-top.id
}

output "policy_bottom_ID" {
  value = nsxt_policy_security_policy.policy-bottom.id
}