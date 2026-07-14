

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "servers" {
  description = "EC2 server names"
  type        = set(string)
}

variable "common_tags" {
  type = map(string)
}