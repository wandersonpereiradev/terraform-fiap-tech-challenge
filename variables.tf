variable "db_instance_name" {
  description = "Nome da instância do banco de dados"
  type        = string
  default     = "fiap-self-service-db"
}

variable "db_username" {
  description = "Nome do usuário do banco de dados"
  type        = string
  default     = "fiap-self-service"
}

variable "db_password" {
  description = "Senha do usuário do banco de dados"
  type        = string
  default     = "fiap-self-service"
  sensitive   = true  # Para não expor a senha nos logs
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
  default     = "fiapSelfServiceDB"
}