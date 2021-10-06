resource "aws_ecr_repository" "ab-ecr-repo" {
  name  = "${var.myname}-${var.projectname}-ecr-repo"
}

resource "aws_ssm_parameter" "ab-ssm-ecr-store" {
  name  = "/${var.myname}-${var.projectname}/ecr_repository_url"
  type  = "String"
  value = aws_ecr_repository.ab-ecr-repo.repository_url
}