#create vpc
resource "aws_vpc" "my_vpc" {
  cidr_block = var.dev_cidr
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "dev-vpc"
  }
}

#Public subnets
resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet1
  map_public_ip_on_launch = "true"
  availability_zone = var.zone_name1
  tags = {
    Name = "Public_Subnet1"
  }
}


resource "aws_subnet" "public_subnet2" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet2
  map_public_ip_on_launch = "true"
  availability_zone = var.zone_name2
  tags = {
    Name = "Public_Subnet2"
  }
}

#Private subnets
resource "aws_subnet" "private_subnet1" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet1
  map_public_ip_on_launch = "true"
  availability_zone = var.zone_name1
  tags = {
    Name = "private_subnet_1"
  }
}

#Internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "internet_gateway"
  }
}


#Routing table for public subnets
resource "aws_route_table" "public_routing" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public Route"
  }
}
#assosiate public subnets with public RT
resource "aws_route_table_association" "public_subnet1" {
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_routing.id
}


resource "aws_route_table_association" "public_subnet2" {
  subnet_id = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_routing.id
}

# Creating EIP
resource "aws_eip" "nat" {
  domain   = "vpc"
}

#Nat gateway
resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.private_subnet1.id
}

#Routing table for private subnet
resource "aws_route_table" "privat_routing" {
    vpc_id = aws_vpc.my_vpc.id
route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.gw.id
    }
tags = {
        Name = "private_routing"
    }
}

#assosiate public subnets with private RT
resource "aws_route_table_association" "private_subnet1" {
    subnet_id = aws_subnet.private_subnet1.id
    route_table_id = aws_route_table.privat_routing.id
}

