##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

resource "aws_api_gateway_domain_name" "this" {
  for_each    = toset(var.apigw_domains)
  domain_name = format("%s.%s", each.value, var.domain_zone)

  regional_certificate_arn = var.acm_certificate_arn

  endpoint_configuration {
    types = var.endpoint_config_types
  }

  security_policy = "TLS_1_2"

  tags = merge({
    Name = var.name_prefix != "" ? format("apigw-%s-%s-%s", var.name_prefix, each.value, local.system_name) : format("apigw-%s-%s", each.value, local.system_name)
    },
  local.all_tags)
}

resource "aws_api_gateway_account" "this" {
  count               = var.cloudwatch_role_enabled ? 1 : 0
  cloudwatch_role_arn = aws_iam_role.cloudwatch[count.index].arn
}
