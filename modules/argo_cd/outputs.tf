data "kubernetes_service" "argocd_server" {
  metadata {
    name      = "argocd-server"
    namespace = var.namespace
  }

  depends_on = [helm_release.argocd]
}

data "kubernetes_secret" "argocd_admin" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = var.namespace
  }

  depends_on = [helm_release.argocd]
}

output "argocd_server_service_name" {
  description = "Service name for Argo CD server"
  value       = data.kubernetes_service.argocd_server.metadata[0].name
}

output "argocd_namespace" {
  description = "Namespace where Argo CD is deployed"
  value       = var.namespace
}

output "argocd_admin_password_b64" {
  description = "Base64-encoded Argo CD admin password (from secret)"
  value       = try(data.kubernetes_secret.argocd_admin.data["password"], null)
  sensitive   = true
}