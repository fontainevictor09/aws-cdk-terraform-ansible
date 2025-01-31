# aws/variables.tf

variable "vm_count" {
  description = "Le nombre d'instances EC2 à créer"
  type        = number
}

variable "aws_region" {
  description = "Région AWS"
  type        = string
}

variable "vpc_id" {
  description = "ID du VPC où les instances EC2 seront créées"
  type        = string
}

variable "ssh_key_name" {
  description = "Clé SSH créée dans AWS IAM"
  type        = string
}