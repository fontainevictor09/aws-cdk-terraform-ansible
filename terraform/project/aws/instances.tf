resource "aws_security_group" "ssh_access" {
  name        = "ssh-access"
  description = "Allow SSH access"
  vpc_id      = var.vpc_id # Ajoutez la variable vpc_id si nécessaire

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Autoriser l'accès SSH depuis n'importe où (vous pouvez restreindre l'IP si nécessaire)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Permet toutes les connexions sortantes
  }

  tags = {
    Name = "ssh-access"
  }
}


resource "aws_instance" "ec2_instances" {
  count         = var.vm_count
  ami           = "ami-0359cb6c0c97c6607" # Remplace par une AMI Debian
  instance_type = "t3.micro"
  key_name      = var.ssh_key_name

  security_groups = [aws_security_group.ssh_access.name] # Utilisation du groupe de sécurité créé par Terraform
  
  tags = {
    Name = "AWS-Instance-${count.index + 1}"
  }
}
