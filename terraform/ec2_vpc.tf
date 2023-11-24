resource "aws_vpc" "custom_vpc" {
  cidr_block            = "10.0.0.0/16"
  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = {
    Name = "Custom VPC"
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1d"

  tags = {
    Name = "Private Subnet 2"
  }
}

resource "aws_security_group" "allow_my_ssh2" {
  name        = "allow_my_ssh2"
  description = "Allow SSH inbound traffic"

  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    description = "SSH from any source"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh2"
  }
}
