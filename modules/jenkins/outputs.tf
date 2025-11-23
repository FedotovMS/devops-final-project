data "kubernetes_service" "jenkins" {
  metadata {
    name      = helm_release.jenkins.name
    namespace = var.namespace
  }

  depends_on = [helm_release.jenkins]
}

data "kubernetes_secret" "jenkins_admin" {
  metadata {
    name      = helm_release.jenkins.name
    namespace = var.namespace
  }

  depends_on = [helm_release.jenkins]
}

output "jenkins_service_name" {
  description = "Kubernetes Service name for Jenkins UI"
  value       = data.kubernetes_service.jenkins.metadata[0].name
}

output "jenkins_namespace" {
  description = "Namespace where Jenkins is deployed"
  value       = var.namespace
}

output "jenkins_admin_password_b64" {
  description = "Jenkins admin password (base64 from Kubernetes Secret)"
  value       = data.kubernetes_secret.jenkins_admin.data["jenkins-admin-password"]
  sensitive   = true
}