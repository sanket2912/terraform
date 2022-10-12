data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }

}

data "aws_ami" "aws-linux-2-leatest" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

data "aws_ami_ids" "aws-linux-2-leatest-ids" {
  owners = ["amazon"]
}