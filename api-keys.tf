##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#
resource "aws_api_gateway_api_key" "api_keys" {
  for_each    = var.api_keys
  name        = var.name_prefix != "" ? "api-key-${var.name_prefix}-${each.key}" : "api-key-${each.key}"
  description = each.value.description
  enabled     = each.value.enabled
  value       = each.value.value
  tags        = local.all_tags
}