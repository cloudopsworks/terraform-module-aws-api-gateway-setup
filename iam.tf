##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

data "aws_iam_policy_document" "assume_role" {
  count = var.cloudwatch_role_enabled ? 1 : 0
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "cloudwatch" {
  count              = var.cloudwatch_role_enabled ? 1 : 0
  name               = "apigw-logging-${local.system_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role[count.index].json
  tags               = local.all_tags
}

data "aws_iam_policy_document" "cloudwatch" {
  count = var.cloudwatch_role_enabled ? 1 : 0
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents",
    ]

    resources = ["*"]
  }
  statement {
    actions = [
      "logs:CreateLogDelivery",
      "logs:PutResourcePolicy",
      "logs:UpdateLogDelivery",
      "logs:DeleteLogDelivery",
      "logs:CreateLogGroup",
      "logs:DescribeResourcePolicies",
      "logs:GetLogDelivery",
      "logs:ListLogDeliveries"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy" "cloudwatch" {
  count  = var.cloudwatch_role_enabled ? 1 : 0
  name   = "CloudwatchLogging"
  role   = aws_iam_role.cloudwatch[count.index].id
  policy = data.aws_iam_policy_document.cloudwatch[count.index].json
}
