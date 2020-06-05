output "rds_endpoint" {
  description = "Endpoint url of created RDS"
  value       = module.endpoint.value
}

output "rds_sg_id" {
  description = "Security Group ID allows to connect to RDS"
  value       = module.rds_instance.security_group_id
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

output "root_username" {
  value = var.db_root_user
}

output "root_password" {
  value = var.master_password != "" ? var.master_password : module.rds_pass.value
}

output "password_ssm_arn" {
  value = module.rds_pass.ssm_arn
}

output "password_ssm_name" {
  value = module.rds_pass.ssm_name
}

output "endpoint_ssm_arn" {
  value = module.endpoint.ssm_arn
}

output "db_name" {
  value = var.dbname
}