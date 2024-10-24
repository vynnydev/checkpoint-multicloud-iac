resource "aws_vpc" "vpc10" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc10"
  }
}

resource "aws_vpc" "vpc20" {
  cidr_block           = "20.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc20"
  }
}

# SUBNETS
resource "aws_subnet" "sn_vpc10_pub" {
  vpc_id            = aws_vpc.vpc10.id
  cidr_block        = "10.0.1.0/24"  # Subnet válida dentro do range da VPC
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "sn_vpc20_priv" {
  vpc_id            = aws_vpc.vpc20.id
  cidr_block        = "10.0.2.0/24"  # Subnet válida dentro do range da VPC
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet"
  }
}

# VPC PEERING
resource "aws_vpc_peering_connection" "vpc_peering" {
    peer_vpc_id   = aws_vpc.vpc20.id
    vpc_id        = aws_vpc.vpc10.id
    auto_accept   = true  
    tags = {
        Name = "vpc_peering"
    }
}
