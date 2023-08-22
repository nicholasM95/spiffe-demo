resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "public vpc for demo spiffe"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Internet gateway db demo spiffe"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "eu-west-1a"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet for demo spiffe 1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "eu-west-1b"
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet for demo spiffe 2"
  }
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "demospiffe"
  subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  tags = {
    Name = "subnet group for demo spiffe"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "route table for demo spiffe"
  }
}

resource "aws_route_table_association" "subet_1_to_route_table" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subet_2_to_route_table" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "security_group" {
  name        = "spiffe demo sg"
  description = "Allow inbound traffic for PG"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "PG connection"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    # cidr_blocks      = [aws_vpc.vpc.cidr_block]
    # ipv6_cidr_blocks = [aws_vpc.vpc.ipv6_cidr_block]
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_instance" "database" {
  depends_on = [aws_internet_gateway.internet_gateway]

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
  db_subnet_group_name                = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids              = [aws_security_group.security_group.id]
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