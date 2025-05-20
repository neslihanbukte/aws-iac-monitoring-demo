variable "vpc_id" {}
variable "subnet_id" {}
variable "security_group_id" {}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key"
  public_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.example.private_key_pem
  filename        = "${path.module}/terraform-key.pem"
  file_permission = "0400"
}

resource "aws_instance" "web" {
    ami           = "ami-009082a6cd90ccd0e"
    instance_type = "t2.micro"
    subnet_id     = var.subnet_id
    vpc_security_group_ids = [var.security_group_id]
    associate_public_ip_address = true
    key_name = aws_key_pair.deployer.key_name

    tags = {
        Name = "flask-instance"
    }
}

resource "aws_eip" "static" {
  instance = aws_instance.web.id
  vpc = true
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

terraform {
  backend "local" {}
}
