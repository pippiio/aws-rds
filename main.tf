
locals {
  config = defaults(var.config, {
    port           = 3306
    engine         = "mysql"
    engine_version = "8.0"
    instance_name  = "db"
    instance_type  = "db.t3.small"
    volume_size    = 30
    multi_az       = false
    username       = "admin"
  })

  username                = local.config.replicate_source_db != null ? null : local.config.username
  password                = local.config.replicate_source_db != null ? null : one(aws_ssm_parameter.this).value
  engine                  = local.config.replicate_source_db != null ? null : local.config.engine
  engine_version          = local.config.replicate_source_db != null ? null : local.config.engine_version
  backup_retention_period = local.config.replicate_source_db != null ? 0 : 30

  major_engine_version = split(".", local.config.engine_version)[0]
}
