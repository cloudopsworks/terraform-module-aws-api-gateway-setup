##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "name_prefix" {
  description = "Prefix for the name of the resources"
  type        = string
  default     = ""
}

variable "apigw_domains" {
  description = "List of API Gateway Domain Names to create"
  type = list(object({
    domain_name         = string
    version             = optional(number, 1)       # Default version is 1 if not specified
    acm_certificate_arn = optional(string, "")      # Optional ACM Certificate ARN
    endpoint_type       = optional(string, "")      # Default endpoint type is null, which will use the default from the variable
    security_policy     = optional(string, "")      # Default security policy is null, which will use the default from the variable
    ip_address_type     = optional(string, "ipv4")  # Default IP address type is ipv4
    mutual_tls          = optional(map(string), {}) # Optional Mutual TLS configuration
  }))
  default = []
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
  nullable    = false
}

variable "security_policy" {
  description = "Security Policy for the API Gateway Domain Names"
  type        = string
  default     = "TLS_1_2"
  nullable    = false
}

variable "rest_vpc_link_arn" {
  description = "VPC Link ARN for the REST API (Load Balancer)"
  type        = string
  default     = ""
}

##
# Variable for HTTP API Gateway VPC Link
# This variable is used to define the VPC Link for HTTP API Gateway.
# http_vpc_link:
#   security_group_ids: List of security group IDs to associate with the VPC Link.
#   subnet_ids: List of subnet IDs to associate with the VPC Link.
#   vpc_id: The VPC ID where the VPC Link will be created.
variable "http_vpc_link" {
  description = "VPC Link for HTTP API Gateway"
  type        = any
  default     = {}
}

variable "cloudwatch_role_enabled" {
  description = "Enable CloudWatch Role for API Gateway Account"
  type        = bool
  default     = true
  nullable    = false
}

variable "cross_account" {
  description = "The cross account to use for the Certificate domain, aws.cross_account provider must be set to module."
  type        = bool
  default     = false
  nullable    = false
}