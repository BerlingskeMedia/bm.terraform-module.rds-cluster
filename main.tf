
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
  source = "git@github.com:BerlingskeMedia/bm.terraform-module.secrets?ref=tags/0.1.2"
  //source = "../bm.terraform-module.secrets"
  enabled        = var.enabled
  namespace      = var.namespace
  stage          = var.stage
  name           = var.name
  tags           = var.tags
  labeled_path   = true
  var_name       = "rds_endpoint"
  parameter_type = "String"
  value          = module.rds_instance.instance_endpoint
  attributes      = var.attributes
}

module "rds_pass" {
  source = "git@github.com:BerlingskeMedia/bm.terraform-module.secrets?ref=tags/0.1.2"
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

module "rds_instance" {
    source                      = "git::https://github.com/cloudposse/terraform-aws-rds.git?ref=tags/0.19.0"
    namespace                   = var.namespace
    stage                       = var.stage
    name                        = var.name
    security_group_ids          = var.allowed_sg
    database_name               = var.dbname
    database_user               = var.db_root_user
    database_password           = module.rds_pass.value
    database_port               = var.db_port
    multi_az                    = var.db_multi_az_deploy
    storage_type                = var.db_storage_type
    allocated_storage           = var.db_allocated_storage
    storage_encrypted           = var.db_storage_encrypted
    engine                      = var.db_engine
    engine_version              = var.db_engine_version
    instance_class              = var.db_instance_type
    db_parameter_group          = var.db_parameter_group
    option_group_name           = var.db_option_group_name
    publicly_accessible         = false
    subnet_ids                  = var.subnets
    vpc_id                      = var.vpc_id
    snapshot_identifier         = var.db_restore_snapshot_id
    auto_minor_version_upgrade  = true
    allow_major_version_upgrade = false
    apply_immediately           = false
    maintenance_window          = var.db_maintainance_window
    skip_final_snapshot         = false
    copy_tags_to_snapshot       = true
    backup_retention_period     = var.db_backup_retention_period
    backup_window               = var.db_backup_window
    tags                        = var.tags
    attributes                  = var.attributes

    db_parameter                = var.db_parameter
    db_options                  = var.db_options
}