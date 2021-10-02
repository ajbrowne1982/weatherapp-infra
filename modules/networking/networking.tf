#Create VPC
resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.1.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "abrowne-project-vpc"
  }
}

#Create public subnets
resource "aws_subnet" "public_subnet" {
  count = 3

  cidr_block        = "10.0.${count.index}.0/28"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = var.az
  }
}

#Create private subnets
resource "aws_subnet" "public_subnet" {
  count = 3

  cidr_block        = "10.0.${count.index}.0/26"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = var.az
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "abrowne-project-igw"
  }
}

# resource "aws_default_route_table" "public_" {
#   default_route_table_id = "${aws_vpc.main.main_route_table_id}"

#   tags = {
#     Name = "defaultpublic"
#   }
# }

# resource "aws_route" "public_internet_gateway" {
#   route_table_id         = "${aws_default_route_table.public.id}"
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = "${aws_internet_gateway.igw.id}"

#   timeouts {
#     create = "5m"
#   }
# }

# resource "aws_route_table_association" "public" {
#   count          = "3"
#   subnet_id      = "${element(aws_subnet.subnet.*.id, count.index)}"
#   route_table_id = "${aws_default_route_table.public.id}"
# }