resource "aws_key_pair" "mykey" {
 key_name = "terra-keyy"
 public_key = file("/home/ubuntu/.ssh/terra-keyy.pub")
 }
resource "aws_default_vpc" "default_vpc"{

}

resource "aws_security_group" "allow_my_ssh2" {
  name        = "allow_my_ssh2"
  description = "Allow ssh inbound traffic"

  # using default VPC
  vpc_id      = aws_default_vpc.default_vpc.id
  ingress {
    description = "TLS from VPC"

    # we should allow incoming and outoging
    # TCP packets
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    # allow all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_ssh2"
  }
}

resource "aws_instance" "manager_instance" {
 key_name = aws_key_pair.mykey.key_name
 ami             = var.ec2-ubuntu-ami
 instance_type   = "t2.micro"
 security_groups = [aws_security_group.allow_my_ssh2.name]

 tags= {
  Name = "Manager-node(with terraform)"
}
}

resource "aws_instance" "worker_instance1" {
 key_name = aws_key_pair.mykey.key_name
 ami             = var.ec2-ubuntu-ami
 instance_type   = "t2.micro"
 security_groups = [aws_security_group.allow_my_ssh2.name]

 tags= {
  Name = "Worker-node1 (with terraform)"
}

}


resource "aws_instance" "worker_instance2" {
 key_name = aws_key_pair.mykey.key_name
 ami             = var.ec2-ubuntu-ami
 instance_type   = "t2.micro"
 security_groups = [aws_security_group.allow_my_ssh2.name]

 tags= {
  Name = "Worker-node2 (with terraform)"
}
}
