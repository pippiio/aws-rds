locals {
  create_kms_key = var.config.kms_key_id == null ? 1 : 0
  kms_key        = coalesce(var.config.kms_key_id, aws_kms_key.this[0].arn)
}

data "aws_iam_policy_document" "kms" {
  statement {
    resources = ["*"]
    actions   = ["kms:*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.id}:root"]
    }
  }

  statement {
    effect    = "Allow"
    resources = ["*"]
    actions   = ["*"]

    principals {
      type        = "Service"
      identifiers = ["rds.amazonaws.com"]
    }
  }

  statement {
    sid       = "Allow Lambda CloudWatch Logs"
    resources = ["*"]
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    principals {
      type        = "Service"
      identifiers = ["logs.${local.region_name}.amazonaws.com"]
    }

    condition {
      test     = "ArnEquals"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values = [
        "arn:aws:logs:${local.region_name}:${local.account_id}:log-group:/aws/rds/instance/${local.name_prefix}${var.config.instance_name}/audit",
        "arn:aws:logs:${local.region_name}:${local.account_id}:log-group:/aws/rds/instance/${local.name_prefix}${var.config.instance_name}/error",
        "arn:aws:logs:${local.region_name}:${local.account_id}:log-group:/aws/rds/instance/${local.name_prefix}${var.config.instance_name}/general",
        "arn:aws:logs:${local.region_name}:${local.account_id}:log-group:/aws/rds/instance/${local.name_prefix}${var.config.instance_name}/slowquery",
      ]
    }
  }
}

resource "aws_kms_key" "this" {
  count = local.create_kms_key

  description         = "KMS CMK used by RDS Database"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.kms.json

  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}rds-kms"
  })
}

resource "aws_kms_alias" "this" {
  count = local.create_kms_key

  name          = "alias/${local.name_prefix}rds-kms-cmk"
  target_key_id = aws_kms_key.this[0].key_id
}
