variable "config" {
  description = ""
  type = object({
    vpc_id                 = string
    subnet_ids             = set(string)
    engine                 = optional(string, "mysql")
    engine_version         = optional(string, "8.0")
    db_name                = optional(string, "db")
    port                   = optional(number, 3306)
    instance_type          = optional(string, "db.t3.small")
    instance_name          = optional(string)
    volume_size            = optional(number, 30)
    multi_az               = optional(bool, false)
    replicate_source_db    = optional(string)
    username               = optional(string, "admin")
    client_security_groups = optional(set(string))
    backup_window          = optional(string, "01:30-02:59")
    maintenance_window     = optional(string, "Sat:03:00-Sat:04:00")
    kms_key_id             = optional(string)
  })
}
