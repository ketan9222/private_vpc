#add vpc
resource "aws_vpc" "ketan-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"  

  tags = {
    Name = "ketan-vpc"
  }
}
#add public subnet'
resource "aws_subnet" "my_public_subnet-1" {
  vpc_id     = aws_vpc.ketan-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "my_public_subnet-1"
  }
}
resource "aws_subnet" "my_public_subnet-2" {
  vpc_id     = aws_vpc.ketan-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "my_public_subnet-2"
  }
}
resource "aws_subnet" "my_public_subnet-3" {
  vpc_id     = aws_vpc.ketan-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "my_public_subnet-3"
  }
}

#add private subnet
resource "aws_subnet" "my_private_subnet-1" {
  vpc_id     = aws_vpc.ketan-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "my_private_subnet-1"
  }
}
resource "aws_subnet" "my_private_subnet-2" {
  vpc_id     = aws_vpc.ketan-vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "my_private_subnet-2"
  }
}
resource "aws_subnet" "my_private_subnet-3" {
  vpc_id     = aws_vpc.ketan-vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "my_private_subnet-3"
  }
}

#add internetgateway
resource "aws_internet_gateway" "ketan-igw" {
  vpc_id = aws_vpc.ketan-vpc.id

  tags = {
    Name = "ketan-igw"
  }
}

#Routing table
resource "aws_route_table" "my-public-route" {
  vpc_id = aws_vpc.ketan-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ketan-igw.id
  }

  tags = {
    Name = "my-public-route"
  }
}

#Routing table association
resource "aws_route_table_association" "public-association-1" {
  subnet_id      = aws_subnet.my_public_subnet-1.id
  route_table_id = aws_route_table.my-public-route.id
}

resource "aws_route_table_association" "public-association-2" {
  subnet_id      = aws_subnet.my_public_subnet-2.id
  route_table_id = aws_route_table.my-public-route.id
}

resource "aws_route_table_association" "public-association-3" {
  subnet_id      = aws_subnet.my_public_subnet-3.id
  route_table_id = aws_route_table.my-public-route.id
}

