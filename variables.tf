variable "namespace" {
  type = string
}
variable "stage" {
  type = string
}
variable "name" {
  type = string
}
variable "master_password" {
  type    = string
  default = ""
}
variable "rds_port" {
  type = string
}
variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}
variable "attributes" {
  type        = list(string)
  description = "Additional attributes (_e.g._ \"1\")"
  default     = []
  #sane default
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter between `namespace`, `stage`, `name` and `attributes`"
  #sane default
}

variable "enabled" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
  default     = false
}

##### RDS Instance settings related

variable "db_allowed_sg" {
  type        = list(string)
  default     = []
  description = "List of Security Group IDs which will be allowed to connect with RDS"
}

variable "db_engine" {
  type        = string
  default     = "mysql"
  description = "The name of the database engine to be used for this DB cluster. example: `mysql`, `postgres`"
}

variable "db_engine_version" {
  type        = string
  default     = "5.7.28"
  description = "Version of choosen database engine"
}

variable "db_port" {
  type        = number
  default     = 3306
  description = "Database port number"
}

variable "db_parameter_group" {
  type        = string
  description = "Database cluster parameter group name"
  default     = null
}

variable "db_parameter" {
  type        = list(object({
    apply_method = string
    name         = string
    value        = string
  }))
  default     = []
  description = "Database cluster custom parameters list"
}

variable "db_option_group_name" {
  type        = string
  description = "Database cluster option group name"
  default     = null
}

variable "db_options" {
  type        = list(object({
    db_security_group_memberships  = list(string)
    option_name                    = string
    port                           = number
    version                        = string
    vpc_security_group_memberships = list(string)

    option_settings = list(object({
      name  = string
      value = string
    }))
  }))
  default     = []
  description = "Database cluster custom options"
}

variable "db_multi_az_deploy" {
  type        = bool
  description = "Set if you want to have standby database in different AZ"
  default     = false
}

variable "db_instance_type" {
  type        = string
  description = "Instance type"
  default     = "db.t3.small"
}

variable "db_root_user" {
  type        = string
  description = "Root user name"
  default     = "admin"
}

variable "db_storage_type" {
  type        = string
  description = "How much storage database needs"
  default     = "gp2"
}

variable "db_allocated_storage" {
  type        = number
  description = "How much storage database needs"
  default     = 100
}

variable "db_storage_encrypted" {
  type        = bool
  description = "How much storage database needs"
  default     = false
}

variable "db_maintenance_window" {
  type        = string
  description = "Define custom maintenance window. Must be fifferent than `db_backup_window`"
  default     = null
}

variable "db_backup_window" {
  type        = string
  description = "Define custom backup window. Must be fifferent than `db_maintenance_window`"
  default     = null
}

variable "db_backup_retention_period" {
  type        = number
  description = "Define backup retention in days. Must be > 0 to enable backups"
  default     = null
}

variable "db_restore_snapshot_id" {
  type        = string
  description = "Pass snapshot id if you want to create database from snapshot"
  default     = null
}

#######################

variable "dbname" {
  type        = string
  description = "Database name"
  default     = "dbname"
}