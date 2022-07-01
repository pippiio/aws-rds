resource "aws_db_instance" "this" {
  identifier              = "${local.name_prefix}${local.config.instance_name}"
  allocated_storage       = local.config.volume_size
  engine                  = local.engine
  engine_version          = local.engine_version
  instance_class          = local.config.instance_type
  db_name                 = local.config.db_name
  username                = local.username
  password                = local.password
  copy_tags_to_snapshot   = true
  db_subnet_group_name    = aws_db_subnet_group.this.id
  vpc_security_group_ids  = [aws_security_group.instance.id]
  multi_az                = local.config.multi_az
  replicate_source_db     = local.config.replicate_source_db
  backup_retention_period = local.backup_retention_period


  tags = local.default_tags

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

# resource "aws_db_option_group" "this" {
#   name                     =  "${local.name_prefix}option-group"
#   # option_group_description = "Terraform Option Group"
#   engine_name              = local.config.engine
#   major_engine_version     = local.major_engine_version

#   option {
#     option_name = "MARIADB_AUDIT_PLUGIN"

#     option_settings = [
#       {
#         name  = "SERVER_AUDIT_EVENTS"
#         value = "CONNECT"
#       },
#       {
#         name  = "SERVER_AUDIT_FILE_ROTATIONS"
#         value = "37"
#       },
#     ]
#   }
# }
