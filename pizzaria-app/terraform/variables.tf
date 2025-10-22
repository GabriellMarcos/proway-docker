cat > variables.tf << 'EOF'
variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "pizzaria"
}

variable "environment" {
  description = "Ambiente (dev, hom, prod)"
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "git_repo_url" {
  description = "URL do repositório Git"
  type        = string
  default     = "https://github.com/GabriellMarcos/proway-docker"
}
EOF
