##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

# name_prefix: "edge" # (Optional) Prefix added to generated resource names. Default: ""
variable "name_prefix" {
  description = "(Optional) Prefix for the name of the resources. Default: \"\""
  type        = string
  default     = ""
}

# apigw_domains: # (Optional) API Gateway custom domains to create. Default: []
#   - domain_name: "api"             # (Required) Host label, combined with domain_zone. Example: "api" -> "api.example.com"
#     version: 1                     # (Optional) Custom domain type. Valid values: 1 (REST API), 2 (HTTP API). Entries with any other value are ignored. Default: 1
#     acm_certificate_arn: ""        # (Optional) Per-domain ACM certificate ARN. Falls back to acm_certificate_arn, then the ACM helper. Default: ""
#     endpoint_type: "REGIONAL"      # (Optional) Endpoint type override. Valid values: "REGIONAL", "EDGE" (version 1); "REGIONAL" (version 2). Falls back to endpoint_config_types when empty. Default: ""
#     security_policy: "TLS_1_2"     # (Optional) TLS policy override. Valid values: "TLS_1_0", "TLS_1_2" (version 1); "TLS_1_2" (version 2). Falls back to security_policy when empty. Default: ""
#     ip_address_type: "ipv4"        # (Optional) IP address types allowed to invoke the domain, applied to version 2 only. Valid values: "ipv4", "dualstack". Default: "ipv4"
#     mutual_tls:                    # (Optional) Mutual TLS settings, applied to version 2 only. Default: {}
#       truststore_uri: "s3://bucket/truststore.pem" # (Required when mutual_tls is set) S3 URL of the truststore.
#       truststore_version: "1"      # (Optional) S3 object version of the truststore. Requires bucket versioning. Default: latest object
variable "apigw_domains" {
  description = "(Optional) List of API Gateway Domain Names to create. Default: []"
  type = list(object({
    domain_name         = string
    version             = optional(number, 1)
    acm_certificate_arn = optional(string, "")
    endpoint_type       = optional(string, "")
    security_policy     = optional(string, "")
    ip_address_type     = optional(string, "ipv4")
    mutual_tls          = optional(map(string), {})
  }))
  default = []
}

# domain_zone: "example.com" # (Required) Base DNS zone appended to each apigw_domains entry.
variable "domain_zone" {
  description = "(Required) The domain zone to create the domain names in"
  type        = string
}

# acm_certificate_arn: "" # (Optional) Shared ACM certificate ARN for domains without their own. When empty, the ACM helper creates a certificate. Default: ""
variable "acm_certificate_arn" {
  description = "(Optional) ACM Certificate ARN to use for the API Gateway Domain Names. Default: \"\""
  type        = string
  default     = ""
  nullable    = false
}

# endpoint_config_types: # (Optional) Default endpoint types. Valid values: "REGIONAL", "EDGE". Default: ["REGIONAL"]
#   - "REGIONAL"         # A version 1 domain receives a regional certificate while this list contains "REGIONAL", so remove it to use "EDGE" domains.
variable "endpoint_config_types" {
  description = "(Optional) Endpoint Configuration Types for the API Gateway Domain Names. Default: [\"REGIONAL\"]"
  type        = list(string)
  default     = ["REGIONAL"]
  nullable    = false
}

# security_policy: "TLS_1_2" # (Optional) Default TLS policy. Valid values: "TLS_1_0", "TLS_1_2". HTTP API domains accept "TLS_1_2" only. Default: "TLS_1_2"
variable "security_policy" {
  description = "(Optional) Security Policy for the API Gateway Domain Names. Default: \"TLS_1_2\""
  type        = string
  default     = "TLS_1_2"
  nullable    = false
}

# rest_vpc_link_arn: "" # (Optional) Network Load Balancer ARN targeted by a REST API VPC Link. No VPC Link is created when empty. Default: ""
variable "rest_vpc_link_arn" {
  description = "(Optional) VPC Link ARN for the REST API (Load Balancer). Default: \"\""
  type        = string
  default     = ""
}

# http_vpc_link: # (Optional) HTTP API VPC Link definition. Nothing is created when empty. Default: {}
#   vpc_id: "vpc-0123456789abcdef0"    # (Required when http_vpc_link is set) VPC that owns the subnets. Hosts the security group the module creates.
#   subnet_ids:                        # (Required when http_vpc_link is set) Subnet IDs for the VPC Link.
#     - "subnet-0123456789abcdef0"
#   security_group_ids:                # (Optional) Additional security groups. The module always attaches its own. Default: []
#     - "sg-0123456789abcdef0"
variable "http_vpc_link" {
  description = "(Optional) VPC Link for HTTP API Gateway. Default: {}"
  type        = any
  default     = {}
}

# cloudwatch_role_enabled: true # (Optional) Create the IAM role and API Gateway account setting for CloudWatch logging. Default: true
variable "cloudwatch_role_enabled" {
  description = "(Optional) Enable CloudWatch Role for API Gateway Account. Default: true"
  type        = bool
  default     = true
  nullable    = false
}

# cross_account_acm: false # (Optional) Validate the ACM certificate against the Route53 zone reached through the aws.cross_account provider. Default: false
variable "cross_account_acm" {
  description = "(Optional) The cross account to use for the Certificate domain, aws.cross_account provider must be set to module. Default: false"
  type        = bool
  default     = false
  nullable    = false
}

# alerts: # (Optional) Alert settings forwarded to the ACM helper module. Default: {}
#   enabled: false     # (Optional) Enable alerts. Default: false
#   priority: 3        # (Optional) Alert priority. Default: 3
#   sns_topic_arn: ""  # (Optional) SNS topic ARN that receives alerts. Default: ""
variable "alerts" {
  description = "(Optional) Enable alerts for API Gateway. Default: {}"
  type = object({
    enabled       = optional(bool, false)
    priority      = optional(number, 3)
    sns_topic_arn = optional(string, "")
  })
  default  = {}
  nullable = false
}

# client_certificates: # (Optional) API Gateway client certificates, identifier => description. Default: {}
#   partner-a: "Partner A client certificate"
variable "client_certificates" {
  description = "(Optional) Client Certificates map for the api gateway, id => description. Default: {}"
  type        = map(string)
  default     = {}
}

# api_keys: # (Optional) API Gateway API keys keyed by identifier. Default: {}
#   default:
#     description: "Default API key" # (Required) API key description.
#     enabled: true                  # (Optional) Whether callers can use the key. Default: true
#     value: "..."                   # (Optional) Alphanumeric key value, 20 to 128 characters. Generated by AWS when unset. Default: null
variable "api_keys" {
  description = "(Optional) API Keys map for the api gateway, id => { description = string, enabled = bool, value = string }. Default: {}"
  type = map(object({
    description = string
    enabled     = optional(bool, true)
    value       = optional(string, null)
  }))
  default = {}
}
