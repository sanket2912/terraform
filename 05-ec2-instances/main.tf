variable "aws_key_pair" {
  default = "~/aws/aws_keys/myVirginiaKey.pem"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30"
    }
  }
}
//HTTP Server -> SG
//SG -> 80 TCP, 22 TCP(for ssh) ,CIDR blk [] -range of ip addresses

provider "aws" {
  region = "us-east-1"
}
resource "aws_default_vpc" "default" {
  
}

data "aws_subnets" "default_subnets" {
  filter {
    name = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
  
}
resource "aws_security_group" "http_server_sg" {
  name   = "http_server_sg"
  vpc_id = aws_default_vpc.default.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "name" = "http_server_sg"
  }
}

resource "aws_instance" "http_server" {
  ami                    = "ami-026b57f3c383c2eec"
  key_name               = "myVirginiaKey"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  subnet_id              = data.aws_subnets.default_subnets.ids[0]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",                                                                              //install httpd
      "sudo service httpd start",                                                                               //start
      "echo Welcome to scalables -Virtual Server is at ${self.public_dns} | sudo tee /var/www/html/index.html " //copy a file
    ]
  }
}
