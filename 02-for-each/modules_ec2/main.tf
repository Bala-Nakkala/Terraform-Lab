resource "aws_instance" "web" {

  for_each = var.servers

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = merge(
    var.common_tags,
    {
      Name = each.key
    }
  )
}