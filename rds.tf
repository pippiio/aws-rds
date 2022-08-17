resource "aws_db_instance" "this" {
  identifier              = "${local.name_prefix}${local.config.instance_name}"
  allocated_storage       = local.config.volume_size
  engine                  = local.config.engine
  engine_version          = local.config.engine_version
  instance_class          = local.config.instance_type
  db_name                 = local.config.db_name
  username                = local.config.username
  password                = aws_ssm_parameter.this.value
  copy_tags_to_snapshot   = true
  db_subnet_group_name    = aws_db_subnet_group.this.id
  vpc_security_group_ids  = [aws_security_group.instance.id]
  multi_az                = local.config.multi_az
  replicate_source_db     = local.config.replicate_source_db
  backup_retention_period = local.backup_retention_period
  backup_window           = local.config.backup_window
  maintenance_window      = local.config.maintenance_window
  deletion_protection     = true
  # kms_key_id              = local.kms_key

  tags = local.default_tags

  enabled_cloudwatch_logs_exports = [
    "audit",
    "error",
    "general",
    "slowquery",
  ]
  lifecycle {
    ignore_changes = [
      replicate_source_db
    ]
  }
}

resource "aws_db_subnet_group" "this" {
  name        = "${local.name_prefix}db-group"
  description = "DB subnet group for ${local.name_prefix}db"
  subnet_ids  = local.config.subnet_ids

  tags = local.default_tags
}
