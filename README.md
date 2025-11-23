# DevOps Final Project

This repository contains the complete infrastructure and CI/CD pipeline
for deploying a Django application on AWS using Terraform, EKS, Argo CD,
Jenkins, Prometheus, and Grafana.

## 📁 Project Structure

    Project/
    ├── main.tf
    ├── backend.tf
    ├── outputs.tf
    ├── modules/
    │   ├── s3-backend/
    │   ├── vpc/
    │   ├── ecr/
    │   ├── eks/
    │   ├── rds/
    │   ├── jenkins/
    │   └── argo_cd/
    ├── charts/
    │   └── django-app/
    ├── k8s/
    │   └── argo-django-app.yaml
    └── django/

## 🚀 Deployment Steps

1.  Initialize Terraform:

        terraform init

2.  Deploy infrastructure:

        terraform apply

3.  Connect to EKS:

        aws eks update-kubeconfig --name <cluster-name> --region <region>

4.  Deploy Django app image to ECR.

5.  Argo CD syncs the application from GitHub repo.

6.  Monitor using Grafana / Prometheus.

## 🧰 Tools Used

-   AWS (EKS, RDS, ECR, VPC, IAM)
-   Terraform
-   Docker
-   Jenkins
-   Argo CD
-   Prometheus
-   Grafana
-   Kubernetes

## 📦 Application Deployment

The Django application is deployed via a Helm chart located in:

    charts/django-app/

Argo CD pulls the chart automatically from GitHub and applies it to the
EKS cluster.

## 📊 Monitoring

Grafana (port-forward):

    kubectl port-forward svc/kube-prometheus-stack-grafana -n monitoring 3000:80

Prometheus:

    kubectl port-forward svc/kube-prometheus-stack-prometheus -n monitoring 9090:9090

## 🔐 Jenkins Access

    kubectl port-forward svc/jenkins -n jenkins 8080:8080

## ⚠️ Clean Up

To avoid AWS billing:

    terraform destroy
