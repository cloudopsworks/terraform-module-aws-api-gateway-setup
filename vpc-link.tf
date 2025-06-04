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

resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  count              = length(var.http_vpc_link) > 0 ? 1 : 0
  name               = var.name_prefix != "" ? "http-link-${var.name_prefix}-${local.system_name}" : "http-link-${local.system_name}"
  security_group_ids = concat(try(var.http_vpc_link.security_group_ids, []), [aws_security_group.apigw_http[0].id])
  subnet_ids         = var.http_vpc_link.subnet_ids
  tags = merge({
    Name = var.name_prefix != "" ? "vpc-link-${var.name_prefix}-${local.system_name}" : "vpc-link-${local.system_name}"
  }, local.all_tags)
}

resource "aws_security_group" "apigw_http" {
  count       = length(var.http_vpc_link) > 0 ? 1 : 0
  name        = var.name_prefix != "" ? "apigw-http-${var.name_prefix}-${local.system_name}-sg" : "apigw-http-${local.system_name}-sg"
  description = "Security Group for API Gateway HTTP VPC Link"
  vpc_id      = var.http_vpc_link.vpc_id
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "apigw_http_vpc" {
  count = length(var.http_vpc_link) > 0 ? 1 : 0
  id    = var.http_vpc_link.vpc_id
}

resource "aws_security_group_rule" "apigw_http_80" {
  count             = length(var.http_vpc_link) > 0 ? 1 : 0
  security_group_id = aws_security_group.apigw_http[0].id
  description       = "HTTP inbound traffic"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = [data.aws_vpc.apigw_http_vpc[0].cidr_block]
}

resource "aws_security_group_rule" "apigw_http_443" {
  count             = length(var.http_vpc_link) > 0 ? 1 : 0
  security_group_id = aws_security_group.apigw_http[0].id
  description       = "HTTPS inbound traffic"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = [data.aws_vpc.apigw_http_vpc[0].cidr_block]
}