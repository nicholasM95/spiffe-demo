module "aws" {
  source         = "../modules/aws"
  name           = var.name
  namespace      = var.namespace
  region         = var.aws_region
  account        = var.account
  db_name        = var.database_name
  db_user        = var.database_user
  s3_bucket_name = var.s3_bucket_name
}

module "application" {
  source            = "../modules/application"
  name              = var.name
  namespace         = var.namespace
  aws_trust_anchor  = module.aws.trust_anchor
  aws_trust_profile = module.aws.trust_profile
  aws_role          = module.aws.role
  database_url      = module.aws.database_url
  database_user     = var.database_user
  aws_region        = var.aws_region
  aws_bucket        = var.s3_bucket_name
  tag               = "1.0.16"
}