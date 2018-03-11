resource "aws_subnet" "public_a" {
  vpc_id     = "${aws_vpc.herotrip.id}"
  cidr_block = "${var.subnet_cidr_public_a}"

  tags {
    Name = "PUBLIC A"
  }

  availability_zone = "${data.aws_availability_zones.available.names[0]}"
}

resource "aws_subnet" "public_b" {
  vpc_id     = "${aws_vpc.herotrip.id}"
  cidr_block = "${var.subnet_cidr_public_b}"

  tags {
    Name = "PUBLIC B"
  }

  availability_zone = "${data.aws_availability_zones.available.names[1]}"
}

resource "aws_subnet" "private_a" {
  vpc_id     = "${aws_vpc.herotrip.id}"
  cidr_block = "${var.subnet_cidr_private_a}"

  tags {
    Name = "PRIVATE A"
  }

  availability_zone = "${data.aws_availability_zones.available.names[0]}"
}

resource "aws_subnet" "private_b" {
  vpc_id     = "${aws_vpc.herotrip.id}"
  cidr_block = "${var.subnet_cidr_private_b}"

  tags {
    Name = "PRIVATE B"
  }

  availability_zone = "${data.aws_availability_zones.available.names[1]}"
}

# Route Associations

resource "aws_route_table_association" "public_a_association" {
  subnet_id      = "${aws_subnet.public_a.id}"
  route_table_id = "${aws_route_table.public_traffic_a.id}"
}

resource "aws_route_table_association" "public_b_association" {
  subnet_id      = "${aws_subnet.public_b.id}"
  route_table_id = "${aws_route_table.public_traffic_b.id}"
}

resource "aws_route_table_association" "private_a_association" {
  subnet_id      = "${aws_subnet.private_a.id}"
  route_table_id = "${aws_route_table.private_traffic_a.id}"
}

resource "aws_route_table_association" "private_b_association" {
  subnet_id      = "${aws_subnet.private_b.id}"
  route_table_id = "${aws_route_table.private_traffic_b.id}"
}
