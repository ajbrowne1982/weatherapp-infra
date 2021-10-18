variable "myname" {
    description = "my github username used to populate names of resources"
    default = ""
}

variable "projectname" {
    description = "the project name used to populate names of resources"
    default = ""
}

variable "tags" {
    description = "Tags set in the root module"
  default     = {}
}