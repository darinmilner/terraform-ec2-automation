resource "aws_vpc" "mtc-vpc" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = true
  enable_dns_support   = true # true is default but makes the code explicit

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "mtc-public-subnet" {
  vpc_id                  = aws_vpc.mtc-vpc.id
  cidr_block              = var.subnet-cidr
  map_public_ip_on_launch = true # makes public
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev-public-sn"
  }
}

resource "aws_internet_gateway" "mtc-internet-gateway" {
  vpc_id = aws_vpc.mtc-vpc.id

  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "mtc-public-rt" {
  vpc_id = aws_vpc.mtc-vpc.id

  tags = {
    Name = "dev-public-rt"
  }
}

resource "aws_route" "default-route" {
  route_table_id         = aws_route_table.mtc-public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mtc-internet-gateway.id
}

resource "aws_route_table_association" "mtc-rt-assoc" {
  subnet_id      = aws_subnet.mtc-public-subnet.id
  route_table_id = aws_route_table.mtc-public-rt.id
}
