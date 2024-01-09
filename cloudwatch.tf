resource "aws_cloudwatch_log_group" "audit" {
  name              = "/aws/rds/instance/${local.name_prefix}${var.config.instance_name}/audit"
  retention_in_days = 7
  kms_key_id        = local.kms_key
  tags              = local.default_tags
}

resource "aws_cloudwatch_log_group" "error" {
  name              = "/aws/rds/instance/${local.name_prefix}${var.config.instance_name}/error"
  retention_in_days = 7
  kms_key_id        = local.kms_key
  tags              = local.default_tags
}

resource "aws_cloudwatch_log_group" "general" {
  name              = "/aws/rds/instance/${local.name_prefix}${var.config.instance_name}/general"
  retention_in_days = 7
  kms_key_id        = local.kms_key
  tags              = local.default_tags
}

resource "aws_cloudwatch_log_group" "slowquery" {
  name              = "/aws/rds/instance/${local.name_prefix}${var.config.instance_name}/slowquery"
  retention_in_days = 7
  kms_key_id        = local.kms_key
  tags              = local.default_tags
}
