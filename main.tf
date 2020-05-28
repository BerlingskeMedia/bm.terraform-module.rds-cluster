
module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  namespace  = var.namespace
  name       = var.name
  stage      = var.stage
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

module "endpoint" {
  source = "git@github.com:BerlingskeMedia/bm.terraform-module.secrets?ref=tags/0.1.1"
  //source = "../bm.terraform-module.secrets"
  enabled        = var.enabled
  namespace      = var.namespace
  stage          = var.stage
  name           = var.name
  tags           = var.tags
  labeled_path   = true
  var_name       = "rds_endpoint"
  parameter_type = "String"
  value          = module.rds_cluster_aurora_mysql.endpoint
  attributes      = var.attributes
}

module "rds_pass" {
  source = "git@github.com:BerlingskeMedia/bm.terraform-module.secrets?ref=tags/0.1.1"
  //source = "../bm.terraform-module.secrets"
  namespace       = var.namespace
  stage           = var.stage
  name            = var.name
  tags            = var.tags
  enabled         = var.enabled && var.master_password == ""
  parameter_type  = "SecureString"
  kms_encrypt     = var.enabled
  generate_secret = true
  var_name        = "rds_password"
  labeled_path    = true
  attributes      = var.attributes
}



resource "aws_security_group" "rds_sg" {
  count       = var.enabled ? 1 : 0
  name        = "${module.label.id}-in"
  description = "Security group allows to access RDS ${module.label.id}"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, { "Name" = module.label.id })
}

module "rds_cluster_aurora_mysql" {
  source         = "git::https://github.com/cloudposse/terraform-aws-rds-cluster.git?ref=tags/0.21.0"
  namespace      = var.namespace
  stage          = var.stage
  name           = "${var.name}"
  engine         = var.db_engine
  engine_mode    = "provisioned"
  cluster_family = var.db_cluster_family
  cluster_size   = var.db_cluster_size
  admin_user     = var.db_root_user
  admin_password  = module.rds_pass.value
  db_name         = var.dbname
  db_port         = var.rds_port
  instance_type   = "db.t3.small"
  vpc_id          = var.vpc_id
  security_groups = aws_security_group.rds_sg.*.id
  subnets         = var.subnets
  enabled         = var.enabled
  attributes      = var.attributes
}
