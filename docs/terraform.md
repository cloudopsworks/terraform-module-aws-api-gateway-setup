## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.35 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.35 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_certificates"></a> [certificates](#module\_certificates) | git::https://github.com/cloudopsworks/terraform-module-aws-acm-certificate.git | v1.3.6 |
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.10 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_api_gateway_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_account) | resource |
| [aws_api_gateway_api_key.api_keys](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_api_key) | resource |
| [aws_api_gateway_client_certificate.client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_client_certificate) | resource |
| [aws_api_gateway_domain_name.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_domain_name) | resource |
| [aws_api_gateway_vpc_link.vpc_link](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_vpc_link) | resource |
| [aws_apigatewayv2_domain_name.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_domain_name) | resource |
| [aws_apigatewayv2_vpc_link.vpc_link](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_vpc_link) | resource |
| [aws_iam_role.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_security_group.apigw_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.apigw_http_443](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.apigw_http_80](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_vpc.apigw_http_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | (Optional) ACM Certificate ARN to use for the API Gateway Domain Names. Default: "" | `string` | `""` | no |
| <a name="input_alerts"></a> [alerts](#input\_alerts) | (Optional) Enable alerts for API Gateway. Default: {} | <pre>object({<br/>    enabled       = optional(bool, false)<br/>    priority      = optional(number, 3)<br/>    sns_topic_arn = optional(string, "")<br/>  })</pre> | `{}` | no |
| <a name="input_api_keys"></a> [api\_keys](#input\_api\_keys) | (Optional) API Keys map for the api gateway, id => { description = string, enabled = bool, value = string }. Default: {} | <pre>map(object({<br/>    description = string<br/>    enabled     = optional(bool, true)<br/>    value       = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_apigw_domains"></a> [apigw\_domains](#input\_apigw\_domains) | (Optional) List of API Gateway Domain Names to create. Default: [] | <pre>list(object({<br/>    domain_name         = string<br/>    version             = optional(number, 1)<br/>    acm_certificate_arn = optional(string, "")<br/>    endpoint_type       = optional(string, "")<br/>    security_policy     = optional(string, "")<br/>    ip_address_type     = optional(string, "ipv4")<br/>    mutual_tls          = optional(map(string), {})<br/>  }))</pre> | `[]` | no |
| <a name="input_client_certificates"></a> [client\_certificates](#input\_client\_certificates) | (Optional) Client Certificates map for the api gateway, id => description. Default: {} | `map(string)` | `{}` | no |
| <a name="input_cloudwatch_role_enabled"></a> [cloudwatch\_role\_enabled](#input\_cloudwatch\_role\_enabled) | (Optional) Enable CloudWatch Role for API Gateway Account. Default: true | `bool` | `true` | no |
| <a name="input_cross_account_acm"></a> [cross\_account\_acm](#input\_cross\_account\_acm) | (Optional) The cross account to use for the Certificate domain, aws.cross\_account provider must be set to module. Default: false | `bool` | `false` | no |
| <a name="input_domain_zone"></a> [domain\_zone](#input\_domain\_zone) | (Required) The domain zone to create the domain names in | `string` | n/a | yes |
| <a name="input_endpoint_config_types"></a> [endpoint\_config\_types](#input\_endpoint\_config\_types) | (Optional) Endpoint Configuration Types for the API Gateway Domain Names. Default: ["REGIONAL"] | `list(string)` | <pre>[<br/>  "REGIONAL"<br/>]</pre> | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to the resources | `map(string)` | `{}` | no |
| <a name="input_http_vpc_link"></a> [http\_vpc\_link](#input\_http\_vpc\_link) | (Optional) VPC Link for HTTP API Gateway. Default: {} | `any` | `{}` | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Is this a hub or spoke configuration? | `bool` | `false` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | (Optional) Prefix for the name of the resources. Default: "" | `string` | `""` | no |
| <a name="input_org"></a> [org](#input\_org) | Organization details | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_rest_vpc_link_arn"></a> [rest\_vpc\_link\_arn](#input\_rest\_vpc\_link\_arn) | (Optional) VPC Link ARN for the REST API (Load Balancer). Default: "" | `string` | `""` | no |
| <a name="input_security_policy"></a> [security\_policy](#input\_security\_policy) | (Optional) Security Policy for the API Gateway Domain Names. Default: "TLS\_1\_2" | `string` | `"TLS_1_2"` | no |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | Spoke ID Number, must be a 3 digit number | `string` | `"001"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_apigw_account"></a> [apigw\_account](#output\_apigw\_account) | API Gateway account settings with the CloudWatch role ARN and throttle limits, empty when cloudwatch\_role\_enabled is false |
| <a name="output_apigw_domains"></a> [apigw\_domains](#output\_apigw\_domains) | REST API (version 1) custom domains keyed by fully qualified domain name, with ARN, ID, and CloudFront and regional endpoint details |
| <a name="output_apigw_http_vpc_link_id"></a> [apigw\_http\_vpc\_link\_id](#output\_apigw\_http\_vpc\_link\_id) | ID of the HTTP API VPC Link, null when http\_vpc\_link is empty |
| <a name="output_apigw_http_vpc_link_name"></a> [apigw\_http\_vpc\_link\_name](#output\_apigw\_http\_vpc\_link\_name) | Name of the HTTP API VPC Link, null when http\_vpc\_link is empty |
| <a name="output_apigw_rest_vpc_link_id"></a> [apigw\_rest\_vpc\_link\_id](#output\_apigw\_rest\_vpc\_link\_id) | ID of the REST API VPC Link, null when rest\_vpc\_link\_arn is empty |
| <a name="output_apigw_rest_vpc_link_name"></a> [apigw\_rest\_vpc\_link\_name](#output\_apigw\_rest\_vpc\_link\_name) | Name of the REST API VPC Link, null when rest\_vpc\_link\_arn is empty |
| <a name="output_apigw_role_arn"></a> [apigw\_role\_arn](#output\_apigw\_role\_arn) | ARN of the API Gateway CloudWatch logging IAM role, null when cloudwatch\_role\_enabled is false |
| <a name="output_client_certificates"></a> [client\_certificates](#output\_client\_certificates) | API Gateway client certificates keyed by identifier, with ARN, creation and expiration dates, and PEM-encoded public certificate |
