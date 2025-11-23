variable "namespace" {
  description = "Namespace for monitoring stack (Prometheus + Grafana)"
  type        = string
  default     = "monitoring"
}

variable "chart_version" {
  description = "Helm chart version for kube-prometheus-stack"
  type        = string
  default     = "68.4.5" # можна залишити, цього достатньо для навчання
}