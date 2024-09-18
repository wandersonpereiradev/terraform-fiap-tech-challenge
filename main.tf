provider "aws" {
  region = var.aws_region
}

resource "aws_db_instance" "db_instance" {
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  name                 = var.db_name
  username             = var.db_user
  password             = var.db_password
  parameter_group_name = var.parameter_group
  publicly_accessible  = false
  skip_final_snapshot  = true
}
