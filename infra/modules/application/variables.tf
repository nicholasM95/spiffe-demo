variable "namespace" {
  description = "kubernetes namespace"
  type        = string
}

variable "name" {
  description = "application name"
  type        = string
}

variable "tag" {
  description = "image tag"
  type        = string
}

variable "aws_trust_profile" {
  description = "aws trust profile"
  type        = string
}

variable "aws_trust_anchor" {
  description = "aws trust anchor"
  type        = string
}

variable "aws_role" {
  description = "aws role"
  type        = string
}

variable "database_url" {
  description = "database url"
  type        = string
}

variable "database_user" {
  description = "database user"
  type        = string
}

variable "aws_region" {
  description = "aws region"
  type        = string
}

variable "aws_bucket" {
  description = "aws bucket"
  type        = string
}
