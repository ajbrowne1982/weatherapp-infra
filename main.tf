#modules
module "s3_bucket" {
  source = "./modules/s3"
  bucket = var.bucket
  tags   = var.tags
}



module "network" {
  source         = "./modules/networking"
  region         = var.region
  s3_bucket_name = module.s3_bucket.s3_bucket_name
  tags           = var.tags
  projectname    = var.projectname
  myname         = var.myname
}

module "ecr" {
  source      = "./modules/ecr"
  tags        = var.tags
  projectname = var.projectname
  myname      = var.myname
}

module "ecs" {
  source          = "./modules/ecs"
  ecr-repo-url    = module.ecr.ecr-repo-url
  alb_sg          = module.network.alb_sg
  tg_arn          = module.network.tg_arn
  vpc_id          = module.network.vpc_id
  private_subnets = module.network.private_subnets
  tags            = var.tags
  projectname     = var.projectname
  myname          = var.myname
}

#outputs
output "bucket_name" {
  description = "The name of the bucket"
  value       = ["${module.s3_bucket.s3_bucket_name}"]
}

output "bucket_name_arn" {
  description = "The name of the bucket"
  value       = ["${module.s3_bucket.s3_bucket_name_arn}"]
}

output "vpc_id" {
  description = "The VPC ID"
  value       = ["${module.network.vpc_id}"]
}

output "alb_dns_address" {
  description = "The ALB DNS name"
  value       = ["${module.network.alb_dns_address}"]
}
