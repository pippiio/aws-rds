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

resource "aws_db_instance" "replica" {
  identifier = "${local.name_prefix}${var.config.instance_name}-replica"

  instance_class      = var.config.instance_type
  replicate_source_db = aws_db_instance.this.identifier // "msb-test-bigwig-internal"
  storage_encrypted   = true
  skip_final_snapshot = true
  apply_immediately   = true

  enabled_cloudwatch_logs_exports = [
    "audit",
    "error",
    "general",
    "slowquery",
  ]
}

# resource "aws_db_instance" "replica" {
#     allocated_storage                     = var.config.volume_size
#     auto_minor_version_upgrade            = true
#     # db_name                               = "bigwig"
#     # db_subnet_group_name                  = "msb-test-db-group"
#     # delete_automated_backups              = true
#     # deletion_protection                   = false
#     enabled_cloudwatch_logs_exports       = [
#         "audit",
#         "error",
#         "general",
#         "slowquery",
#     ]
#     endpoint                              = "dbreplica.chaiz6lyhp90.eu-central-1.rds.amazonaws.com:3306"
#     engine                                = "mysql"
#     engine_version                        = "8.0.32"
#     engine_version_actual                 = "8.0.32"
#     hosted_zone_id                        = "Z1RLNUO7B9Q6NB"
#     iam_database_authentication_enabled   = false
#     id                                    = "dbreplica"
#     identifier                            = "dbreplica"
#     instance_class                        = "db.t3.micro"
#     iops                                  = 0
#     kms_key_id                            = "arn:aws:kms:eu-central-1:910101673218:key/c1202038-0dff-4308-8458-919f7793de83"
#     license_model                         = "general-public-license"
#     listener_endpoint                     = []
#     maintenance_window                    = "sat:03:00-sat:04:00"
#     master_user_secret                    = []
#     max_allocated_storage                 = 1000
#     monitoring_interval                   = 0
#     # multi_az                              = true
#     # name                                  = "bigwig"
#     # network_type                          = "IPV4"
#     # option_group_name                     = "default:mysql-8-0"
#     # parameter_group_name                  = "default.mysql8.0"
#     # performance_insights_enabled          = false
#     # performance_insights_retention_period = 0
#     # port                                  = 3306
#     # publicly_accessible                   = false
#     # replicas                              = []
#     replicate_source_db                   = "msb-test-bigwig-internal"
#     resource_id                           = "db-MQUJ2YNLQNQ5JLD3YCTKWJR7DA"
#     security_group_names                  = []
#     skip_final_snapshot                   = true
#     status                                = "available"
#     storage_encrypted                     = true
#     storage_throughput                    = 0
#     storage_type                          = "gp2"
#     tags                                  = {}
#     tags_all                              = {}
#     username                              = "admin"
#     vpc_security_group_ids                = [
#         "sg-057d0a69d5fdf83d8",
#     ]
# }