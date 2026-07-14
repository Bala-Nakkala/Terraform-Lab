module "ec2" {
  source = "./modules_ec2"

  servers       = var.servers
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  common_tags = local.common_tags
}