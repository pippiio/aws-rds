resource "random_password" "this" {
  length  = 24
  special = false
}

resource "aws_ssm_parameter" "this" {
  count = local.config.replicate_source_db == null ? 1 : 0

  name        = "/${local.name_prefix}secrets/rds-password"
  description = "The RDS master password."
  type        = "SecureString"
  value       = random_password.this.result
  tags        = local.default_tags
}
