variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "ami_id" {
  description = "Amazon Linux AMI"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
}