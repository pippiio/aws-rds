
resource "aws_security_group" "client" {
  name        = "${local.name_prefix}client-sg"
  description = "Securitygroup for RDS clients"
  vpc_id      = var.config.vpc_id

  tags = merge(local.default_tags, {
    Name = "${local.name_prefix}rds-client-sg"
  })
}

resource "aws_security_group" "instance" {
  name        = "${local.name_prefix}instance-sg"
  description = "Securitygroup for RDS instances"
  vpc_id      = var.config.vpc_id

  ingress {
    description     = "DB TCP Port"
    from_port       = local.port
    to_port         = local.port
    protocol        = "tcp"
    security_groups = setunion([aws_security_group.client.id], var.config.client_security_groups)
    self            = true
  }

  egress {
    from_port = local.port
    to_port   = local.port
    protocol  = "tcp"
    self      = true
  }

  tags = merge(local.default_tags, {
    Name = "${local.name_prefix}rds-instance-sg"
  })
}
