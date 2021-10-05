#Create VPC
resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.1.0/24"
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.myname}-${var.projectname}-vpc"
  }
}

#Create public subnets
resource "aws_subnet" "public_subnet" {
  count      = length(local.public_subnets)
  cidr_block = "${element(values(local.public_subnets), count.index)}"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${element(keys(local.public_subnets), count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.myname}-public-${element(keys(local.public_subnets), count.index)}"
  }
}

#Create private subnets
resource "aws_subnet" "private_subnet" {
  count      = length(local.private_subnets)
  cidr_block = "${element(values(local.private_subnets), count.index)}"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${element(keys(local.public_subnets), count.index)}"
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.myname}-private-${element(keys(local.public_subnets), count.index)}"
  }
}

#create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.myname}-${var.projectname}-igw"
  }
}

#create public route table
resource "aws_route_table" "public" {
  count = length(local.public_subnets)
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.myname}-public-routetable-${element(keys(local.public_subnets), count.index)}"
  }
}

#create routes to internet gateway
resource "aws_route" "public_internet_gateway" {
  count = length(local.public_subnets)
  route_table_id = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"

  timeouts {
    create = "5m"
  }
}

#associate public subnets with the public route tables
resource "aws_route_table_association" "public" {
  count = length(local.public_subnets)
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public[count.index].id}"
}

#create eip for the nat gateways
resource "aws_eip" "ab-nat-eip" {
  count      = length(local.private_subnets)
  vpc = true
  tags = {
    Name = "${var.myname}-eip-${element(keys(local.public_subnets), count.index)}"
  }
}

#create nat gateways
resource "aws_nat_gateway" "nat" {
  count      = length(local.private_subnets)
  allocation_id = aws_eip.ab-nat-eip[count.index].id
  subnet_id     = aws_subnet.private_subnet[count.index].id

  tags = {
    Name = "${var.myname}-nat-${element(keys(local.public_subnets), count.index)}"
  }
}

#create private route tables
resource "aws_route_table" "private" {
  count = length(local.private_subnets)
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.myname}-private-routetable-${element(keys(local.public_subnets), count.index)}"
  }
}

#create routes to nat gateway
resource "aws_route" "private_nat_gateway" {
  count = length(local.private_subnets)
  route_table_id = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat[count.index].id

  timeouts {
    create = "5m"
  }
}

#associate route table with the private subnets
resource "aws_route_table_association" "private" {
  count = length(local.private_subnets)
  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.private[count.index].id}"
}

#create s3 endpoint
resource "aws_vpc_endpoint" "s3-endpoint" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.us-east-1.s3"
}