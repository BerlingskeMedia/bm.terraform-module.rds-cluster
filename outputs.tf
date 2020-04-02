output "rds_endpoint" {
  description = "Endpoint url of created RDS"
  value       = module.rds_cluster_aurora_mysql.endpoint
}