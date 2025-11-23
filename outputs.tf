output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "ECR repository URL for Django app"
}