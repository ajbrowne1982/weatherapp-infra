variable "tags" {
      description = "default tags defined in the root module"
  default     = {}
}
variable "myname" {
    description = "my github username used to populate names of resources"
    default = ""
}

variable "projectname" {
    description = "the project name used to populate names of resources"
    default = ""
}

variable "private_subnets" {
  description = "list of private subnets"
  default = ""
}

variable "ecr-repo-url" {
      description = "ECR repo URL"
  default = ""
}

variable "alb_sg" {
  description = "ALB security group ID"
  default = ""
}

variable "alb_arn" {
  description = "ALB ARN"
  default = ""
}

variable "tg_arn" {
    description = "Target group ARN"
    default = ""
}

variable "vpc_id" {
  description = "VPC ID"
  default = ""
}

variable "int-port" {
  description = "Port used to access the app internally"
  type        = string
  default     = "3000"
}