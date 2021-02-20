resource "aws_vpc" "automuteus" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "${var.application_name}-vpc"
    AppName = var.application_name
  }
}

resource "aws_subnet" "public" {
  cidr_block              = cidrsubnet(aws_vpc.automuteus.cidr_block, 1, 0)
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.automuteus.id

  tags = {
    Name    = "${var.application_name}-public-subnet"
    AppName = var.application_name
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.automuteus.id

  tags = {
    Name    = "${var.application_name}-gateway"
    AppName = var.application_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.automuteus.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name    = "${var.application_name}-public"
    AppName = var.application_name
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
