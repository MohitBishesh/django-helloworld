resource "aws_vpc" "custom_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "Custom VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "Private Subnet 2"
  }
}


resource "aws_security_group" "allow_my_ssh2" {
  name        = "allow_my_ssh2"
  description = "Allow SSH inbound traffic"

  vpc_id = aws_vpc.custom_vpc.id

  # Ingress rule allowing SSH traffic from any source
  ingress {
    description = "SSH from any source"

    # Allow incoming traffic on port 22 (SSH)
    from_port   = 22
    to_port     = 22

    # Allow SSH traffic using the TCP protocol
    protocol    = "tcp"

    # Allow SSH traffic from any source IP address
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule allowing all outbound traffic
  egress {
    # Egress rule allowing all outbound traffic (all protocols, all ports)
    from_port   = 0
    to_port     = 0

    # Allow all outbound traffic to any destination IP address
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tags for identifying the security group
  tags = {
    Name = "allow_ssh2"
  }
}
