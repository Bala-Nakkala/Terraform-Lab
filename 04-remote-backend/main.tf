resource "aws_instance" "web" {

  ami           = "ami-07e88eae8fab7dd8a"
  instance_type = "t3.micro"
  subnet_id     = "subnet-03f0a42fe37959ca7"

  tags = {
    Name = "remote-backend-demo"
  }
}