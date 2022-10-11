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

resource "aws_security_group" "http_server_sg" {
  name   = "http_server_sg"
  vpc_id = "vpc-0b4a1af6285902a84"
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
  ami = "ami-026b57f3c383c2eec"
  key_name = "myVirginiaKey"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.http_server_sg.id]
  subnet_id = "subnet-0376f634782e7d338"
}
