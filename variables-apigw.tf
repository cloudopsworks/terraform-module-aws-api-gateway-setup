##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

variable "apigw_domains" {
  description = "List of API Gateway Domain Names to create"
  type        = list(string)
  default     = []
}

variable "domain_zone" {
  description = "The domain zone to create the domain names in"
  type        = string
}


variable "acm_certificate_arn" {
  description = "ACM Certificate ARN to use for the API Gateway Domain Names"
  type        = string
}

variable "endpoint_config_types" {
  description = "Endpoint Configuration Types for the API Gateway Domain Names"
  type        = list(string)
  default     = ["REGIONAL"]
}