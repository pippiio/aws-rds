locals {
  create_kms_key = local.config.kms_key_id == null ? 1 : 0
  kms_key        = local.config.kms_key_id
}

data "aws_iam_policy_document" "kms" {
  count = local.create_kms_key

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
}

resource "aws_kms_key" "this" {
  count = local.create_kms_key

  description         = "KMS CMK used by RDS Database"
  enable_key_rotation = true
  policy              = one(data.aws_iam_policy_document.kms).json

  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}rds-kms"
  })
}

resource "aws_kms_alias" "this" {
  count = local.create_kms_key

  name          = "alias/${local.name_prefix}rds-kms-cmk"
  target_key_id = one(aws_kms_key.this).key_id
}
