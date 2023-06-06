output "trust_anchor" {
  value = aws_rolesanywhere_trust_anchor.trust_anchor.arn
}

output "trust_profile" {
  value = aws_rolesanywhere_profile.trust_profile.arn
}

output "role" {
  value = aws_iam_role.trust_profile_role.arn
}

output "database_url" {
  value = "jdbc:postgresql://${aws_db_instance.database.endpoint}/${aws_db_instance.database.db_name}?ssl=true&sslmode=require"
}