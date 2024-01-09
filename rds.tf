resource "aws_db_instance" "this" {
  identifier              = "${local.name_prefix}${var.config.instance_name}"
  allocated_storage       = var.config.volume_size
  engine                  = local.engine
  engine_version          = var.config.engine_version
  instance_class          = var.config.instance_type
  db_name                 = var.config.db_name
  username                = local.username
  password                = local.password
  copy_tags_to_snapshot   = true
  db_subnet_group_name    = aws_db_subnet_group.this.id
  vpc_security_group_ids  = setunion([aws_security_group.instance.id], var.config.client_security_groups)
  multi_az                = var.config.multi_az
  replicate_source_db     = var.config.replicate_source_db
  backup_retention_period = local.backup_retention_period
  backup_window           = var.config.backup_window
  maintenance_window      = var.config.maintenance_window
  deletion_protection     = true
  storage_encrypted       = true
  kms_key_id              = local.kms_key

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
  subnet_ids  = var.config.subnet_ids

  tags = local.default_tags
}
