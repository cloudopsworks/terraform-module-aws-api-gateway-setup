##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

output "apigw_domains" {
  value = {
    for item in aws_api_gateway_domain_name.this : item.domain_name => {
      arn                    = item.arn
      id                     = item.id
      cloudfront_domain_name = item.cloudfront_domain_name
      cloudfront_zone_id     = item.cloudfront_zone_id
      regional_domain_name   = item.regional_domain_name
      regional_zone_id       = item.regional_zone_id
    }
  }
}

output "apigw_account" {
  value = var.cloudwatch_role_enabled ? {
    cloudwatch_role_arn = aws_api_gateway_account.this[0].cloudwatch_role_arn
    burst_limit         = aws_api_gateway_account.this[0].throttle_settings[0].burst_limit
    rate_limit          = aws_api_gateway_account.this[0].throttle_settings[0].rate_limit
  } : {}
}

output "apigw_role_arn" {
  value = try(aws_iam_role.cloudwatch[0].arn, null)
}

output "apigw_rest_vpc_link_name" {
  value = var.rest_vpc_link_arn != "" ? aws_api_gateway_vpc_link.vpc_link[0].name : null
}

output "apigw_rest_vpc_link_id" {
  value = var.rest_vpc_link_arn != "" ? aws_api_gateway_vpc_link.vpc_link[0].id : null
}

output "apigw_http_vpc_link_name" {
  value = length(var.http_vpc_link) > 0 ? aws_apigatewayv2_vpc_link.vpc_link[0].name : null
}

output "apigw_http_vpc_link_id" {
  value = length(var.http_vpc_link) > 0 ? aws_apigatewayv2_vpc_link.vpc_link[0].id : null
}