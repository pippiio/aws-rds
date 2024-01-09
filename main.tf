
locals {
  username                = var.config.replicate_source_db != null ? null : var.config.username
  password                = var.config.replicate_source_db != null ? null : one(aws_ssm_parameter.this).value
  engine                  = var.config.replicate_source_db != null ? null : var.config.engine
  engine_version          = var.config.replicate_source_db != null ? null : var.config.engine_version
  backup_retention_period = var.config.replicate_source_db != null ? 0 : 35

  major_engine_version = split(".", var.config.engine_version)[0]
}
