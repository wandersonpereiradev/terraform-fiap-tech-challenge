provider "aws" {
  region = var.aws_region
}

resource "aws_db_instance" "db_instance" {
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = "fiap-self-service-db"
  username             = "root"
  password             = "root" 
  parameter_group_name = var.parameter_group
  publicly_accessible  = false
  skip_final_snapshot  = true
  apply_immediately    = true

  # Configurações de backup e retenção
  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  
  # Configuração de segurança
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

# Security Group para o banco de dados (controla o tráfego de rede)
resource "aws_security_group" "rds_sg" {
  name        = "rds_security_group"
  description = "Security group para o RDS"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Defina um IP específico para acesso controlado
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Todos os protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }
}