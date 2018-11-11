resource "aws_route_table" "public_traffic_a" {
  vpc_id = "${aws_vpc.eks_vpc.id}"

  tags {
    Name = "PUBLIC A TRAFFIC"
    Environment = "${var.environment}"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}

resource "aws_route_table" "public_traffic_c" {
  vpc_id = "${aws_vpc.eks_vpc.id}"

  tags {
    Name = "PUBLIC C TRAFFIC"
    Environment = "${var.environment}"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}

resource "aws_route_table" "private_traffic_a" {
  vpc_id = "${aws_vpc.eks_vpc.id}"

  tags {
    Name = "PRIVATE A TRAFFIC"
    Environment = "${var.environment}"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_public_a.id}"
  }
}

resource "aws_route_table" "private_traffic_c" {
  vpc_id = "${aws_vpc.eks_vpc.id}"

  tags {
    Name = "PRIVATE C TRAFFIC"
    Environment = "${var.environment}"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_public_c.id}"
  }
}
