resource "aws_cloudwatch_log_group" "this" {
  for_each = { for log in local.cloudwatch_logs_exports : log => log }

  name              = "/aws/rds/instance/${local.name_prefix}${var.config.instance_name}/${each.key}"
  retention_in_days = 7
  kms_key_id        = local.kms_key
  tags              = local.default_tags
}
