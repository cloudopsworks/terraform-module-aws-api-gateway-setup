##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

output "apigw_domains" {
  description = "REST API (version 1) custom domains keyed by fully qualified domain name, with ARN, ID, and CloudFront and regional endpoint details"
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
  description = "API Gateway account settings with the CloudWatch role ARN and throttle limits, empty when cloudwatch_role_enabled is false"
  value = var.cloudwatch_role_enabled ? {
    cloudwatch_role_arn = aws_api_gateway_account.this[0].cloudwatch_role_arn
    burst_limit         = aws_api_gateway_account.this[0].throttle_settings[0].burst_limit
    rate_limit          = aws_api_gateway_account.this[0].throttle_settings[0].rate_limit
  } : {}
}

output "apigw_role_arn" {
  description = "ARN of the API Gateway CloudWatch logging IAM role, null when cloudwatch_role_enabled is false"
  value       = try(aws_iam_role.cloudwatch[0].arn, null)
}

output "apigw_rest_vpc_link_name" {
  description = "Name of the REST API VPC Link, null when rest_vpc_link_arn is empty"
  value       = var.rest_vpc_link_arn != "" ? aws_api_gateway_vpc_link.vpc_link[0].name : null
}

output "apigw_rest_vpc_link_id" {
  description = "ID of the REST API VPC Link, null when rest_vpc_link_arn is empty"
  value       = var.rest_vpc_link_arn != "" ? aws_api_gateway_vpc_link.vpc_link[0].id : null
}

output "apigw_http_vpc_link_name" {
  description = "Name of the HTTP API VPC Link, null when http_vpc_link is empty"
  value       = length(var.http_vpc_link) > 0 ? aws_apigatewayv2_vpc_link.vpc_link[0].name : null
}

output "apigw_http_vpc_link_id" {
  description = "ID of the HTTP API VPC Link, null when http_vpc_link is empty"
  value       = length(var.http_vpc_link) > 0 ? aws_apigatewayv2_vpc_link.vpc_link[0].id : null
}

output "client_certificates" {
  description = "API Gateway client certificates keyed by identifier, with ARN, creation and expiration dates, and PEM-encoded public certificate"
  value = {
    for key, value in var.client_certificates : key => {
      arn             = aws_api_gateway_client_certificate.client[key].arn
      created_date    = aws_api_gateway_client_certificate.client[key].created_date
      expiration_date = aws_api_gateway_client_certificate.client[key].expiration_date
      pem             = aws_api_gateway_client_certificate.client[key].pem_encoded_certificate
    }
  }
}