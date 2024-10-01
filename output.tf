##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
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