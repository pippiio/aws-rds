
locals {
  username                = var.config.replicate_source_db != null ? null : var.config.username
  password                = var.config.replicate_source_db != null ? null : one(aws_secretsmanager_secret_version.rds_password_version).secret_string
  engine                  = var.config.replicate_source_db != null ? null : var.config.engine
  engine_version          = var.config.replicate_source_db != null ? null : var.config.engine_version
  port                    = coalesce(var.config.port, local.engine_default_port[local.engine])
  backup_retention_period = var.config.replicate_source_db != null ? 0 : 35
  cloudwatch_logs_exports = coalesce(var.config.cloudwatch_log_exports, local.engine_exports[local.engine])

  major_engine_version = split(".", var.config.engine_version)[0]

  engine_default_port = {
    mysql    = 3306
    postgres = 5432
    mssql    = 1433
    oracle   = 1521
  }

  engine_exports = {
    mysql    = ["audit", "error", "general", "slowquery"]
    postgres = ["postgresql", "upgrade"]
    mssql    = ["agent", "error"]
    oracle   = ["alert", "audit", "listener", "trace"]
  }
}
