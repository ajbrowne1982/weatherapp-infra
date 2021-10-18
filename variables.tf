variable "myname" {
  description = "my github username used to populate names of resources"
  type        = string
  default     = "abrowne"
}

variable "projectname" {
  description = "the project name used to populate names of resources"
  type        = string
  default     = "weather-app"
}

variable "bucket" {
  type        = string
  description = "Specifies the name of an S3 Bucket"
  default     = "abrowne-weatherapp-tf-bucket"
}

variable "tags" {
  type        = map(string)
  description = "Use tags to identify project resources"
  default     = {
    Owner   = "Andrew Browne"
    Project = "Weather App"
  }
}

variable "region" {
  type        = string
  description = "Set's the region"
  default     = "us-east-1"
}

variable "alb-name" {
  type        = string
  description = "Set's the alb name"
  default     = "abrowne-weatherapp-alb"
}

