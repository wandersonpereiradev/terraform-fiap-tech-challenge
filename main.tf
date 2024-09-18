provider "aws" {
  region = "us-east-1"  # Altere para a região desejada
}

resource "aws_db_instance" "meu_banco_dados" {
  identifier             = var.db_instance_name  # Nome do banco de dados
  engine                = "mysql"  # Tipo de banco de dados
  engine_version        = "8.0.35"  # Versão do banco
  instance_class        = "db.t2.micro"  # Tipo de instância
  allocated_storage      = 20  # Espaço em GB
  username              = var.db_username  # Nome de usuário
  password              = var.db_password  # Senha
  db_name               = var.db_name  # Nome do banco de dados
  skip_final_snapshot   = true  # Não criar snapshot final ao deletar
}

output "endpoint" {
  value = aws_db_instance.meu_banco_dados.endpoint
}