module "s3_bucket" {
  source = "./modules/s3"
  bucket = var.bucket

  tags = var.tags
}

output "bucket_name" {
  description = "The name of the bucket"
  value       = ["${module.s3_bucket.s3_bucket_name}"]
}

output "bucket_name_arn" {
  description = "The name of the bucket"
  value       = ["${module.s3_bucket.s3_bucket_name_arn}"]
}

module "network" {
  source       = "./modules/networking"
  region       = var.region
  ecr-repo-url = module.ecr.ecr-repo-url
  # module.vpc.vpc.id

}

output "vpc" {
  description = "The VPC ID"
  value       = ["${module.network.vpc}"]
}

module "ecr" {
  source = "./modules/ecr"
}
