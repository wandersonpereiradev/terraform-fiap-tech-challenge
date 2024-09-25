provider "aws" {
  region = var.aws_region
}

resource "aws_db_instance" "db_instance" {
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = "fiapSelfServiceDb"
  username             = "root"
  password             = "fiaproot"
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

resource "aws_docdb_cluster_instance" "docdb_instance" {
  identifier           = "fiap-self-service-document-db-instance"
  cluster_identifier   = aws_docdb_cluster.docdb_cluster.id
  instance_class       = "db.r5.large"
  apply_immediately    = true
}

# DocumentDB Cluster
resource "aws_docdb_cluster" "docdb_cluster" {
  cluster_identifier   = "fiap-self-service-pagamentos"
  master_username      = "root"
  master_password      = "fiaproot"
  engine               = "docdb"
  engine_version       = "4.0.0"
  apply_immediately    = true
  skip_final_snapshot  = true
}

# DynamoDB Table
resource "aws_dynamodb_table" "dynamo_db" {
  name           = "fiap-self-service-pedidos-ativos"
  billing_mode   = "PAY_PER_REQUEST"

  hash_key       = "id"         # Definindo "id" como chave primária (hash key)
  range_key      = "created_at" # Definindo "created_at" como chave de classificação (range key)
  attribute {
    name = "id"
    type = "S" # Tipo String
  }

  attribute {
    name = "created_at"
    type = "S" # Tipo String para armazenar datas
  }

  tags = {
    Name = "fiap-self-service-pedidos-ativos"
  }
}

# Security Group para o banco de dados (controla o tráfego de rede)
resource "aws_security_group" "rds_sg" {
  name        = "rds_security_group"
  description = "Security group para o RDS e DocumentDB"

  ingress {
    from_port   = 3306 # Porta MySQL (RDS)
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Defina um IP específico para acesso controlado
  }

  ingress {
    from_port   = 27017 # Porta MongoDB (DocumentDB)
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Todos os protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }
}