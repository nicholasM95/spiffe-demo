resource "helm_release" "read_aws_resources" {
  name             = var.name
  chart            = "${path.module}/../../../application"
  namespace        = var.namespace
  create_namespace = "true"

  values = [
    file("${path.module}/../../../application/values.yaml")
  ]

  set {
    name  = "serviceAccount.name"
    value = var.name
  }

  set {
    name  = "image.tag"
    value = var.tag
  }

  set {
    name  = "aws.trustProfile"
    value = var.aws_trust_profile
  }

  set {
    name  = "aws.trustAnchor"
    value = var.aws_trust_anchor
  }

  set {
    name  = "aws.role"
    value = var.aws_role
  }

  set {
    name  = "database.url"
    value = var.database_url
  }

  set {
    name  = "database.user"
    value = var.database_user
  }

  set {
    name  = "aws.region"
    value = var.aws_region
  }

  set {
    name  = "aws.bucket"
    value = var.aws_bucket
  }
}