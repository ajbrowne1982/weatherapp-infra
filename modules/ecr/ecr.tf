resource "aws_ecr_repository" "ab-ecr-repo" {
  name  = "${var.myname}-${var.projectname}-ecr-repo"
  tags = var.tags
}

resource "aws_ssm_parameter" "ab-ssm-ecr-store" {
  name  = "/${var.myname}-${var.projectname}/ecr_repository_url"
  type  = "String"
  value = aws_ecr_repository.ab-ecr-repo.repository_url
}

# Outputs
output "ecr-repo-name" {
    description = "ECR repository name"
    value       = aws_ecr_repository.ab-ecr-repo.name
}

output "ecr-repo-id" {
    description = "ECR repository id"
    value       = aws_ecr_repository.ab-ecr-repo.id
}

output "ecr-repo-url" {
    description = "ECR repository url"
    value       = aws_ecr_repository.ab-ecr-repo.repository_url
}