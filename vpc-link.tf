##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

resource "aws_api_gateway_vpc_link" "vpc_link" {
  count       = var.rest_vpc_link_arn != "" ? 1 : 0
  name        = var.name_prefix != "" ? "vpc-link-${var.name_prefix}-${local.system_name}" : "vpc-link-${local.system_name}"
  description = "VPC Link for API Gateway - ${local.system_name}"
  target_arns = [var.rest_vpc_link_arn]
  tags = merge({
    Name = var.name_prefix != "" ? "vpc-link-${var.name_prefix}-${local.system_name}" : "vpc-link-${local.system_name}"
  }, local.all_tags)
}