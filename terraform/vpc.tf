resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "vpc"
  }
}

resource "aws_subnet" "private" {
  for_each          = var.private-subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "private-subnet-${each.value}"
  }

}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id          = aws_vpc.vpc.id
  service_name    = "com.amazonaws.${var.region}.dynamodb"
  route_table_ids = [aws_vpc.vpc.main_route_table_id]
}

data "aws_security_group" "private" {
  name   = "default"
  vpc_id = aws_vpc.vpc.id
}
