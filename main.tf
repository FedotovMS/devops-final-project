module "s3_backend" {
  source       = "./modules/s3-backend"
  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
}

#VPC
###########################################

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  environment  = var.environment

  azs = [
    "${var.aws_region}a",
    "${var.aws_region}b"
  ]
}

#EKS
###########################################
module "eks" {
  source             = "./modules/eks"
  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  cluster_name       = "${var.project_name}-${var.environment}-eks"

  node_instance_types = ["t3.small"]
  desired_size        = 2
  min_size            = 1
  max_size            = 3
}

#ECR
###########################################
module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
  environment  = var.environment
  image_name   = "django-app"
}

#jenkins
###########################################
module "jenkins" {
  source = "./modules/jenkins"

  namespace      = "jenkins"
  admin_user     = "admin"
  admin_password = "admin123" # можеш змінити

  depends_on = [module.eks]

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }
}

#Argo Cd
###########################################
module "argo_cd" {
  source = "./modules/argo_cd"

  namespace     = "argocd"
  chart_version = "7.6.12"

  depends_on = [module.eks]

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }
}

#monitoring
###########################################
module "monitoring" {
  source = "./modules/monitoring"

  namespace     = "monitoring"
  chart_version = "65.3.1"

  depends_on = [module.eks]

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }
}