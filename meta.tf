terraform {
  required_version = ">= 0.13.0"
  backend "s3" {
    bucket = "pathways-dojo"
    key    = "ajbrowne1982-tfstate-main"
    region = "us-east-1"
  }
}