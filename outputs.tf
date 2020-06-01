output "rds_endpoint" {
  description = "Endpoint url of created RDS"
  value       = module.endpoint.value
}

output "rds_sg_id" {
  description = "Security Group ID allows to connect to RDS"
  value       = join("", aws_security_group.rds_sg.*.id)
}

output "ssm_arns" {
  value = concat(module.endpoint.ssm_arn, module.rds_pass.ssm_arn)
}

output "kms_arns" {
  value = concat(module.rds_pass.kms_arn)
}

output "kms_arn" {
  value = module.rds_pass.kms_arn_single
}

output "kms_key_id" {
  value = module.rds_pass.kms_key_id
}

output "dbuser_arns" {
  value = [for db_id in module.rds_cluster_aurora_mysql.dbi_resource_ids :
    "arn:aws:rds-db:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:dbuser:${db_id}/${var.db_root_user}"
  ]
}

output "root_username" {
  value = var.db_root_user
}

output "password_ssm_arn" {
  value = module.rds_pass.ssm_arn
}

output "endpoind_ssm_arn" {
  value = module.endpoint.ssm_arn
}

output "db_name" {
  value = var.dbname
}