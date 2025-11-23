variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "image_name" {
  description = "Base name for ECR repository"
  type        = string
  default     = "django-app"
}