variable "namespace" {
  description = "kubernetes namespace"
  type        = string
  default     = "spiffe"
}

variable "name" {
  description = "application name"
  type        = string
  default     = "file-read-app"
}

variable "account" {
  description = "aws account id"
  type        = string
}

variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "eu-west-1"
}

variable "database_user" {
  description = "database user"
  type        = string
  default     = "app-user"
}

variable "database_name" {
  description = "database name"
  type        = string
  default     = "demospiffe"
}

variable "s3_bucket_name" {
  description = "s3 bucket name"
  type        = string
  default     = "demospiffe"
}