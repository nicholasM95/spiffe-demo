variable "namespace" {
  description = "kubernetes namespace"
  type        = string
}

variable "name" {
  description = "application name"
  type        = string
}

variable "region" {
  description = "aws region"
  type        = string
}

variable "account" {
  description = "aws account"
  type        = string
}

variable "db_name" {
  description = "database name"
  type        = string
}

variable "db_user" {
  description = "database user"
  type        = string
}

variable "s3_bucket_name" {
  description = "s3 bucket name"
  type        = string
}
