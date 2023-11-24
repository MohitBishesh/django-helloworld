provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "mykey" {
  key_name   = "terra-keyy"
  public_key = file("/home/ubuntu/.ssh/terra-keyy.pub")
}

data "aws_subnet" "private_subnets" {
  for_each = toset(["us-east-1b", "us-east-1c"])

  vpc_id = aws_vpc.custom_vpc.id
  filter {
    name   = "availabilityZone"
    values = [each.key]
  }
}

resource "aws_instance" "manager_instance" {
  key_name        = aws_key_pair.mykey.key_name
  ami             = var.ec2-ubuntu-ami
  instance_type   = "t2.micro"
  subnet_id       = data.aws_subnet.private_subnets["us-east-1b"].id
  security_groups = [aws_security_group.allow_my_ssh2.id]

  tags = {
    Name = "Manager-node(with terraform)"
  }
}

resource "aws_instance" "worker_instance1" {
  key_name        = aws_key_pair.mykey.key_name
  ami             = var.ec2-ubuntu-ami
  instance_type   = "t2.micro"
  subnet_id       = data.aws_subnet.private_subnets["us-east-1c"].id
  security_groups = [aws_security_group.allow_my_ssh2.id]

  tags = {
    Name = "Worker-node1 (with terraform)"
  }
}

resource "aws_instance" "worker_instance2" {
  key_name        = aws_key_pair.mykey.key_name
  ami             = var.ec2-ubuntu-ami
  instance_type   = "t2.micro"
  subnet_id       = data.aws_subnet.private_subnets["us-east-1c"].id
  security_groups = [aws_security_group.allow_my_ssh2.id]

  tags = {
    Name = "Worker-node2 (with terraform)"
  }
}
