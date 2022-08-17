variable "config" {
  description = ""
  type = object({
    vpc_id                 = string
    subnet_ids             = set(string)
    engine                 = optional(string)
    engine_version         = optional(string)
    db_name                = optional(string)
    port                   = optional(number)
    instance_type          = optional(string)
    instance_name          = optional(string)
    volume_size            = optional(number)
    multi_az               = optional(bool)
    replicate_source_db    = optional(string)
    username               = optional(string)
    client_security_groups = optional(set(string))
    backup_window          = optional(string)
    maintenance_window     = optional(string)
    kms_key_id             = optional(string)
  })
}
