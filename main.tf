##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

resource "aws_api_gateway_domain_name" "this" {
  for_each    = var.apigw_domains
  domain_name = format("%s.%s", each.value, var.domain_zone)

  regional_certificate_arn = var.acm_certificate_arn

  endpoint_configuration {
    types = var.endpoint_config_types
  }

  security_policy = "TLS_1_2"

  tags = local.all_tags
}

resource "aws_api_gateway_account" "this" {
  cloudwatch_role_arn = aws_iam_role.cloudwatch.arn
}
