module "rds_cluster_aurora_mysql" {
  source         = "git::https://github.com/cloudposse/terraform-aws-rds-cluster.git?ref=tags/0.21.0"
  namespace      = var.namespace
  stage          = var.stage
  name           = "${var.name}-rds"
  engine         = var.engine
  engine_mode    = "provisioned"
  cluster_family = var.cluster_family
  cluster_size   = var.cluster_size
  admin_user     = var.master_user_name
  //admin_password  = data.aws_kms_secrets.rds.plaintext["master_password"]
  admin_password  = var.master_password
  db_name         = var.db_name
  db_port         = var.rds_port
  instance_type   = var.instance_type
  vpc_id          = var.vpc_id
  security_groups = var.security_groups
  subnets         = var.subnets
  enabled         = var.enabled
}

resource "aws_ssm_parameter" "secret" {
  count       = var.enabled ? 1 : 0
  name        = "/${var.namespace}/${var.stage}/${var.name}/rds_endpoint"
  description = "RDS endpoint url"
  type        = "String"
  value       = module.rds_cluster_aurora_mysql.endpoint
  tags        = var.tags
}

