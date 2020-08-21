# Internet VPC
resource "aws_vpc" "mediawiki_vpc" {
  cidr_block           = var.AWS_CIDR_VPC
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "main"
  }
}

# Subnets
resource "aws_subnet" "mediawiki-public-1" {
  vpc_id                  = aws_vpc.mediawiki_vpc.id
  cidr_block              = var.AWS_CIDR_SUBNET1
  map_public_ip_on_launch = "true"
  availability_zone       = var.AZS[0]

  tags = {
    Name = "main-public-1"
  }
}

resource "aws_subnet" "mediawiki-public-2" {
  vpc_id                  = aws_vpc.mediawiki_vpc.id
  cidr_block              = var.AWS_CIDR_SUBNET2
  map_public_ip_on_launch = "true"
  availability_zone       = var.AZS[1]

  tags = {
    Name = "main-public-2"
  }
}

resource "aws_subnet" "mediawiki-private-1" {
  vpc_id                  = aws_vpc.mediawiki_vpc.id
  cidr_block              = var.AWS_CIDR_SUBNET3
  map_public_ip_on_launch = "false"
  availability_zone       = var.AZS[2]
  tags = {
    Name = "main-private-1"
  }
}


# Internet GW
resource "aws_internet_gateway" "mediawiki-gw" {
  vpc_id = aws_vpc.mediawiki_vpc.id

  tags = {
    Name = "main"
  }
}

# route tables
resource "aws_route_table" "mediawiki-public" {
  vpc_id = aws_vpc.mediawiki_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mediawiki-gw.id
  }

  tags = {
    Name = "main-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.mediawiki-public-1.id
  route_table_id = aws_route_table.mediawiki-public.id
}

resource "aws_route_table_association" "mediawiki-public-2-a" {
  subnet_id      = aws_subnet.mediawiki-public-2.id
  route_table_id = aws_route_table.mediawiki-public.id
}

