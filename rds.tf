resource "aws_db_instance" "this" {
  identifier                          = "${local.name_prefix}${var.config.instance_name}"
  allocated_storage                   = var.config.volume_size
  engine                              = local.engine
  engine_version                      = var.config.engine_version
  port                                = local.port
  instance_class                      = var.config.instance_type
  db_name                             = var.config.db_name
  username                            = local.username
  password                            = local.password
  copy_tags_to_snapshot               = true
  db_subnet_group_name                = aws_db_subnet_group.this.id
  vpc_security_group_ids              = setunion([aws_security_group.instance.id], var.config.client_security_groups)
  multi_az                            = var.config.multi_az
  replicate_source_db                 = var.config.replicate_source_db
  backup_retention_period             = local.backup_retention_period
  backup_window                       = var.config.backup_window
  maintenance_window                  = var.config.maintenance_window
  deletion_protection                 = true
  storage_encrypted                   = true
  kms_key_id                          = local.kms_key
  enabled_cloudwatch_logs_exports     = local.cloudwatch_logs_exports
  tags                                = local.default_tags
  iam_database_authentication_enabled = var.config.iam_authentication

  lifecycle {
    ignore_changes = [
      replicate_source_db,
      instance_class,
    ]
  }
}

resource "aws_db_subnet_group" "this" {
  name        = "${local.name_prefix}db-group"
  description = "DB subnet group for ${local.name_prefix}db"
  subnet_ids  = var.config.subnet_ids

  tags = local.default_tags
}

resource "aws_db_instance" "replica" {
  count = var.config.replicas.count

  identifier                      = "${local.name_prefix}${var.config.instance_name}-replica-${count.index}"
  instance_class                  = coalesce(var.config.replicas.instance_type, var.config.instance_type)
  replicate_source_db             = aws_db_instance.this.identifier
  storage_encrypted               = true
  skip_final_snapshot             = true
  apply_immediately               = true
  enabled_cloudwatch_logs_exports = local.cloudwatch_logs_exports
  tags                            = local.default_tags
}
