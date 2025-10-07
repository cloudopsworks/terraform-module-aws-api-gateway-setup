##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#
resource "aws_api_gateway_client_certificate" "client" {
  for_each    = var.client_certificates
  description = each.value
  tags        = local.all_tags
}