resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_instance" "database" {
  allocated_storage                   = 5
  iam_database_authentication_enabled = true
  identifier                          = var.db_name
  db_name                             = var.db_name
  engine                              = "postgres"
  engine_version                      = "14.7"
  instance_class                      = "db.t3.micro"
  username                            = "foobar"
  password                            = random_password.password.result
  publicly_accessible                 = true
  skip_final_snapshot                 = true
}

resource "postgresql_role" "db_user" {
  name       = var.db_user
  login      = true
  roles      = ["rds_iam"]
  depends_on = [aws_db_instance.database]
  lifecycle {
    prevent_destroy = true
  }
}