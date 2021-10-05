variable "myname" {
    description = "my github username used to populate names of resources"
    type = string
    default = "ajbrowne1982"
}

variable "projectname" {
    description = "the project name used to populate names of resources"
    type = string
    default = "weather-app"
}

variable "region" {
  type  = string
  default = ""
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

variable "port" {
  description = "list of ports allowed in the security group"
  type = string
  default = "80"
}

variable "protocol" {
  description = "protocol used"
  type = string
  default = "HTTP"
}

variable "alb-name" {
    description = "ALB security group name"
    type = string
    default = "abrowne-weather-app-alb"
}

variable "alb-sg-name" {
    description = "ALB security group name"
    type = string
    default = "abrowne-weather-app-alb-sg"
}