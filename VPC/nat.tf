#defining the elastc ip association

resource "aws_eip" "my-elasicip" {
  vpc      = true
}0

#NAT Gateway
resource "aws_nat_gateway" "my-NAT" {
  allocation_id = aws_eip.my-elasicip.id
  subnet_id     = aws_subnet.my_public_subnet-1.id

  tags = {
    Name = "my-NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.ketan-igw]
}


#Private Route table
resource "aws_route_table" "my-private-route" {
  vpc_id = aws_vpc.ketan-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my-NAT.id
  }


  tags = {
    Name = "my-private-route"
  }
}

#route association private
resource "aws_route_table_association" "private-association-1" {
  subnet_id      = aws_subnet.my_private_subnet-1.id
  route_table_id = aws_route_table.my-private-route.id
}

resource "aws_route_table_association" "private-association-2" {
  subnet_id      = aws_subnet.my_private_subnet-2.id
  route_table_id = aws_route_table.my-private-route.id
}

resource "aws_route_table_association" "private-association-3" {
  subnet_id      = aws_subnet.my_private_subnet-3.id
  route_table_id = aws_route_table.my-private-route.id
}