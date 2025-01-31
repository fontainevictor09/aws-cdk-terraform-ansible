variable "aws_region" {
  default = "eu-west-3"
}

variable "vm_count" {
  default = 1
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "ssh_key_name" {
  description = "Clé SSH créée dans AWS IAM"
  type        = string
}