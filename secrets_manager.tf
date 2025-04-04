
resource "aws_secretsmanager_secret" "rds_password" {
  count = var.config.replicate_source_db == null ? 1 : 0

  name        = "/rds/${local.name_prefix}${var.config.instance_name}/password"
  description = "The RDS master password for ${local.name_prefix}${var.config.instance_name}."
  kms_key_id  = local.kms_key
  tags        = local.default_tags
}

resource "aws_secretsmanager_secret_version" "rds_password_version" {
  count         = var.config.replicate_source_db == null ? 1 : 0
  secret_id     = aws_secretsmanager_secret.rds_password[0].id
  secret_string = random_password.this.result
}
