##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  domains_list = [
    for d in var.apigw_domains : d.domain_name
    if d.acm_certificate_arn != "" && var.acm_certificate_arn != ""
  ]
}

module "certificates" {
  providers = {
    aws               = aws
    aws.cross_account = aws.cross_account
  }
  is_hub       = var.is_hub
  spoke_def    = var.spoke_def
  org          = var.org
  extra_tags   = var.extra_tags
  source       = "git::https://github.com/cloudopsworks/terraform-module-aws-acm-certificate.git?ref=v1.2.6"
  create       = length(local.domains_list) > 0
  domain_zone  = var.domain_zone
  domain_alias = format("%s.%s", try(local.domains_list[0], ""), var.domain_zone)
  domain_alternates = [
    for d in local.domains_list : format("%s.%s", d, var.domain_zone)
    if d != try(local.domains_list[0], "")
  ]
  cross_account = var.cross_account
  alerts        = var.alerts
}