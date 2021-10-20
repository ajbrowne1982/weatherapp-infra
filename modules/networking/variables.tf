variable "myname" {
  description = "my github username used to populate names of resources"
  default     = ""
}

variable "projectname" {
  description = "the project name used to populate names of resources"
  default     = ""
}

variable "region" {
  type    = string
  default = ""
}

variable "tags" {
  description = "default tags defined in the root module"
  default     = {}
}

locals {
  public_subnets = {
    "${var.region}a" = "10.0.1.0/28"
    "${var.region}b" = "10.0.1.16/28"
    "${var.region}c" = "10.0.1.32/28"
  }
}

locals {
  private_subnets = {
    "${var.region}a" = "10.0.1.64/26"
    "${var.region}b" = "10.0.1.128/26"
    "${var.region}c" = "10.0.1.192/26"
  }
}

variable "ext-port" {
  description = "Port used to access the app externally"
  type        = string
  default     = "80"
}

variable "int-port" {
  description = "Port used to access the app internally"
  type        = string
  default     = "3000"
}

variable "protocol" {
  description = "protocol used"
  type        = string
  default     = "HTTP"
}

variable "alb-name" {
  description = "ALB security group name"
  type        = string
  default     = "abrowne-weather-app-alb"
}

variable "alb-sg-name" {
  description = "ALB security group name"
  type        = string
  default     = "abrowne-weather-app-alb-sg"
}

variable "s3_bucket_name" {
  description = "s3 bucket name"
  default     = ""
}
