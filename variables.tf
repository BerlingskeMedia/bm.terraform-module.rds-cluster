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

variable "db_engine" {
  type        = string
  default     = "aurora-mysql"
  description = "The name of the database engine to be used for this DB cluster. Valid values: `aurora`, `aurora-mysql`, `aurora-postgresql`"
}

variable "db_cluster_family" {
  type        = string
  default     = "aurora-mysql5.7"
  description = "The family of the DB cluster parameter group"
}

variable "db_cluster_size" {
  type        = string
  description = "How many instances should run in cluster"
  default     = "1"
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

variable "allowed_sg" {
  type        = list(string)
  default     = []
  description = "List of Security Group IDs which will be allowed to connect with RDS"
}

variable "dbname" {
  type        = string
  description = "Database name"
  default     = "dbname"
}

variable "allowed_sgs" {
  type        = list(string)
  description = "List of SG ids to allow connection to RDS"
  default     = []
}
