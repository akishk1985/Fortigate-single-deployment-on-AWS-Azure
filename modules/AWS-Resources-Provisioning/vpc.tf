// AWS VPC 
resource "aws_vpc" "fgtvm-vpc" {
  cidr_block           = var.AWS-vpccidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "terraform demo"
  }
}

resource "aws_subnet" "publicsubnetaz1" {
  vpc_id                  = aws_vpc.fgtvm-vpc.id
  cidr_block              = var.AWS-publiccidraz1
  availability_zone       = var.az1
  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet az1"
  }
}

resource "aws_subnet" "privatesubnetaz1" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.AWS-privatecidraz1
  availability_zone = var.az1
  tags = {
    Name = "private subnet az1"
  }
}
