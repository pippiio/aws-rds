
locals {
  config = var.config

  username                = local.config.replicate_source_db != null ? null : local.config.username
  password                = local.config.replicate_source_db != null ? null : one(aws_ssm_parameter.this).value
  engine                  = local.config.replicate_source_db != null ? null : local.config.engine
  engine_version          = local.config.replicate_source_db != null ? null : local.config.engine_version
  backup_retention_period = local.config.replicate_source_db != null ? 0 : 35

  major_engine_version = split(".", local.config.engine_version)[0]
}
