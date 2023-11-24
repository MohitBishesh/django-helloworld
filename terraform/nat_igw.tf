locals {
  worker_instance_ids = tolist([
    aws_instance.worker_instance1.id,
    aws_instance.worker_instance2.id,
  ])
}

resource "aws_nat_gateway" "nat_gateway" {
  count = length(local.worker_instance_ids)

  allocation_id = local.worker_instance_ids[count.index]
  subnet_id     = aws_subnet.private_subnet1.id
}

resource "aws_route_table" "private_subnet1_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[0].id
  }
}

resource "aws_route_table_association" "private_subnet1_association" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_subnet1_route_table.id
}

resource "aws_nat_gateway" "nat_gateway2" {
  count = length(local.worker_instance_ids)

  allocation_id = local.worker_instance_ids[count.index]
  subnet_id     = aws_subnet.private_subnet2.id
}

resource "aws_route_table" "private_subnet2_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[1].id
  }
}

resource "aws_route_table_association" "private_subnet2_association" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_subnet2_route_table.id
}
