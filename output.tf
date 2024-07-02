##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

output "apigw_domains" {
  value = {
    for item in var.apigw_domains : item => {
      arn                    = aws_api_gateway_domain_name.this[item].arn
      id                     = aws_api_gateway_domain_name.this[item].id
      cloudfront_domain_name = aws_api_gateway_domain_name.this[item].cloudfront_domain_name
      cloudfront_zone_id     = aws_api_gateway_domain_name.this[item].cloudfront_zone_id
      regional_domain_name   = aws_api_gateway_domain_name.this[item].regional_domain_name
      regional_zone_id       = aws_api_gateway_domain_name.this[item].regional_zone_id
    }
  }
}