resource "aws_ssm_parameter" "host" {
  count = var.config.replicate_source_db == null ? 1 : 0

  name        = "/rds/${local.name_prefix}${var.config.instance_name}/host"
  description = "The RDS hostname."
  type        = "String"
  value       = aws_db_instance.this.address
  tags        = local.default_tags
}

resource "aws_ssm_parameter" "port" {
  count = var.config.replicate_source_db == null ? 1 : 0

  name        = "/rds/${local.name_prefix}${var.config.instance_name}/port"
  description = "The RDS TCP port."
  type        = "String"
  value       = aws_db_instance.this.port
  tags        = local.default_tags
}

resource "aws_ssm_parameter" "database" {
  count = var.config.replicate_source_db == null ? 1 : 0

  name        = "/rds/${local.name_prefix}${var.config.instance_name}/database"
  description = "The RDS default database."
  type        = "String"
  value       = aws_db_instance.this.db_name
  tags        = local.default_tags
}

resource "aws_ssm_parameter" "username" {
  count = var.config.replicate_source_db == null ? 1 : 0

  name        = "/rds/${local.name_prefix}${var.config.instance_name}/username"
  description = "The RDS hostname."
  type        = "String"
  value       = aws_db_instance.this.username
  tags        = local.default_tags
}

resource "aws_ssm_parameter" "password" {
  count = var.config.replicate_source_db == null ? 1 : 0

  name        = "/rds/${local.name_prefix}${var.config.instance_name}/password"
  description = "The RDS master password for ${local.name_prefix}${var.config.instance_name}."
  type        = "SecureString"
  value       = random_password.this.result
  key_id      = local.kms_key
  tags        = local.default_tags
}
