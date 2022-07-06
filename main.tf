
locals {
  config = defaults(var.config, {
    port               = 3306
    engine             = "mysql"
    engine_version     = "8.0"
    instance_type      = "db.t3.small"
    volume_size        = 30
    multi_az           = false
    username           = "admin"
    backup_window      = "01:30-02:59"
    maintenance_window = "Sat:03:00-Sat:04:00"
  })

  major_engine_version = split(".", local.config.engine_version)[0]
}
