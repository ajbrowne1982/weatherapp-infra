variable "region" {
  type  = string
  default = "us-east-1"
}

#Add subnets below
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