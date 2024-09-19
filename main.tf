provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                 = "fiap-self-service"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_db_subnet_group" "fiap-self-service" {
  name       = "fiap-self-service"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "fiap-self-service"
  }
}

resource "aws_security_group" "rds" {
  name   = "fiap-self-service_rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fiap-self-service_rds"
  }
}

resource "aws_db_parameter_group" "fiap-self-service" {
  name   = "fiap-self-service"
  family = "mysql"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "fiap-self-service" {
  identifier             = "fiap-self-service"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "mysql"
  engine_version         = "8.0.35"
  username               = "edu"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.fiap-self-service.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.fiap-self-service.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}