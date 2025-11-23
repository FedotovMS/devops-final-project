variable "namespace" {
  description = "Kubernetes namespace for Jenkins"
  type        = string
  default     = "jenkins"
}

variable "admin_user" {
  description = "Jenkins admin username"
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Jenkins admin password"
  type        = string
  sensitive   = true
  default     = "admin123" # для навчання ок, в реалі краще змінити
}

variable "chart_version" {
  description = "Helm chart version for Jenkins"
  type        = string
  default     = "5.5.7"
}