data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "demo-sg" {
  name        = var.demo-sg-name
  description = "Allow TLS and SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {  
    Name = "allow_tls_and_ssh"
  }
}


resource "aws_instance" "Bastion-Host" {
  count                  = 1
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "demo-key" ## aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.demo-sg.id]
  tags = {
    Name = "demo-Terraform"
  }
}