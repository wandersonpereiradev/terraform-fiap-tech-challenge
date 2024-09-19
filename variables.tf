variable "aws_region" {
  description = "A região da AWS onde a infraestrutura será criada."
  default     = "us-east-1"
}

variable "allocated_storage" {
  description = "Espaço de armazenamento alocado para o banco de dados (em GB)."
  default     = 20
}

variable "engine" {
  description = "O mecanismo de banco de dados a ser usado (ex: 'mysql', 'postgres')."
  default     = "mysql"
}

variable "engine_version" {
  description = "A versão do mecanismo de banco de dados."
  default     = "8.0"
}

variable "instance_class" {
  description = "Tipo de instância do banco de dados."
  default     = "db.t3.micro"
}

variable "parameter_group" {
  description = "Nome do grupo de parâmetros do DB."
  default     = "default.mysql8.0"
}
