## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.99.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.9 |

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_account) | resource |
| [aws_api_gateway_domain_name.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_domain_name) | resource |
| [aws_api_gateway_vpc_link.vpc_link](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_vpc_link) | resource |
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
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | ACM Certificate ARN to use for the API Gateway Domain Names | `string` | n/a | yes |
| <a name="input_apigw_domains"></a> [apigw\_domains](#input\_apigw\_domains) | List of API Gateway Domain Names to create | `list(string)` | `[]` | no |
| <a name="input_cloudwatch_role_enabled"></a> [cloudwatch\_role\_enabled](#input\_cloudwatch\_role\_enabled) | Enable CloudWatch Role for API Gateway Account | `bool` | `true` | no |
| <a name="input_domain_zone"></a> [domain\_zone](#input\_domain\_zone) | The domain zone to create the domain names in | `string` | n/a | yes |
| <a name="input_endpoint_config_types"></a> [endpoint\_config\_types](#input\_endpoint\_config\_types) | Endpoint Configuration Types for the API Gateway Domain Names | `list(string)` | <pre>[<br/>  "REGIONAL"<br/>]</pre> | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_http_vpc_link"></a> [http\_vpc\_link](#input\_http\_vpc\_link) | VPC Link for HTTP API Gateway | `any` | `{}` | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Establish this is a HUB or spoke configuration | `bool` | `false` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the name of the resources | `string` | `""` | no |
| <a name="input_org"></a> [org](#input\_org) | n/a | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_rest_vpc_link_arn"></a> [rest\_vpc\_link\_arn](#input\_rest\_vpc\_link\_arn) | VPC Link ARN for the REST API (Load Balancer) | `string` | `""` | no |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | n/a | `string` | `"001"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apigw_account"></a> [apigw\_account](#output\_apigw\_account) | n/a |
| <a name="output_apigw_domains"></a> [apigw\_domains](#output\_apigw\_domains) | n/a |
| <a name="output_apigw_role_arn"></a> [apigw\_role\_arn](#output\_apigw\_role\_arn) | n/a |
