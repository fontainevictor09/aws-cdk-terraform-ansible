module "aws_vms" {
  source         = "./aws"
  vm_count       = var.vm_count
  aws_region     = var.aws_region
  vpc_id         = var.vpc_id
  ssh_key_name   = var.ssh_key_name
}
