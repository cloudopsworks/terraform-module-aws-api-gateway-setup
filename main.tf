##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

resource "aws_apigatewayv2_domain_name" "this" {
  for_each = {
    for domain in var.apigw_domains : domain.domain_name => domain
    if domain.version == 2
  }
  domain_name = format("%s.%s", each.value.domain_name, var.domain_zone)
  domain_name_configuration {
    certificate_arn = each.value.acm_certificate_arn != null ? each.value.acm_certificate_arn : var.acm_certificate_arn
    security_policy = each.value.security_policy != null ? each.value.security_policy : var.security_policy
    endpoint_type   = each.value.endpoint_type != null ? each.value.endpoint_type : var.endpoint_config_types[0]
    ip_address_type = each.value.ip_address_type
  }
  dynamic "mutual_tls_authentication" {
    for_each = length(each.value.mutual_tls) > 0 ? [1] : []
    content {
      truststore_uri     = each.value.mutual_tls["truststore_uri"]
      truststore_version = try(each.value.mutual_tls["truststore_version"], null)
    }
  }
  tags = merge({
    Name = var.name_prefix != "" ? format("apigw-%s-%s-%s", var.name_prefix, each.value, local.system_name) : format("apigw-%s-%s", each.value, local.system_name)
    },
  local.all_tags)
}

resource "aws_api_gateway_domain_name" "this" {
  for_each = {
    for domain in var.apigw_domains : domain.domain_name => domain
    if domain.version == 1
  }
  domain_name     = format("%s.%s", each.value.domain_name, var.domain_zone)
  certificate_arn = each.value.acm_certificate_arn != null ? each.value.acm_certificate_arn : var.acm_certificate_arn
  security_policy = each.value.security_policy != null ? each.value.security_policy : var.security_policy
  endpoint_configuration {
    types = each.value.endpoint_type != null ? [each.value.endpoint_type] : var.endpoint_config_types
  }
  tags = merge({
    Name = var.name_prefix != "" ? format("apigw-%s-%s-%s", var.name_prefix, each.value, local.system_name) : format("apigw-%s-%s", each.value, local.system_name)
    },
  local.all_tags)
}

resource "aws_api_gateway_account" "this" {
  count               = var.cloudwatch_role_enabled ? 1 : 0
  cloudwatch_role_arn = aws_iam_role.cloudwatch[count.index].arn
}
