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
  type = string
}
variable "rds_port" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "security_groups" {
  type = list(string)
}
variable "subnets" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "enabled" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
  default     = true
}

variable "engine" {
  type        = string
  description = "RDS Engine type"
  default     = "aurora-mysql"
}

variable "cluster_family" {
  type        = string
  description = "RDS cluster family"
  default     = "aurora-mysql5.7"
}

variable "cluster_size" {
  type        = string
  description = "Number of RDS instances in cluster"
  default     = "1"
}

variable "db_name" {
  type        = string
  description = "RDS database name"
  default     = "dbname"
}

variable "master_user_name" {
  type        = string
  description = "Name of master user"
  default     = "admin"
}

variable "instance_type" {
  type        = string
  description = "RDS instance type"
  default     = "db.t3.small"
}
