resource "aws_subnet" "public_a" {
    vpc_id = "${aws_vpc.herotrip.id}"
    cidr_block = "${var.subnet_public_a_cidr}"

    tags {
        Name = "Public A"
    }
}

resource "aws_subnet" "public_c" {
    vpc_id = "${aws_vpc.herotrip.id}"
    cidr_block = "${var.subnet_public_c_cidr}"

    tags {
        Name = "Public C"
    }
}

resource "aws_subnet" "private_a" {
    vpc_id = "${aws_vpc.herotrip.id}"
    cidr_block = "${var.subnet_private_a_cidr}"

    tags {
        Name = "Private A"
    }
}

resource "aws_subnet" "private_c" {
    vpc_id = "${aws_vpc.herotrip.id}"
    cidr_block = "${var.subnet_private_c_cidr}"

    tags {
        Name = "Private C"
    }
}

resource "aws_subnet" "db_a" {
    vpc_id = "${aws_vpc.herotrip.id}"
    cidr_block = "${var.subnet_db_a_cidr}"

    tags {
        Name = "Private DB A"
    }
}

resource "aws_subnet" "db_c" {
    vpc_id = "${aws_vpc.herotrip.id}"
    cidr_block = "${var.subnet_db_c_cidr}"

    tags {
        Name = "Private DB C"
    }
}

resource "aws_route_table_association" "public_a_association" {
  subnet_id      = "${aws_subnet.public_a.id}"
  route_table_id = "${aws_route_table.public_traffic_a.id}"
}

resource "aws_route_table_association" "public_c_association" {
  subnet_id      = "${aws_subnet.public_c.id}"
  route_table_id = "${aws_route_table.public_traffic_c.id}"
}

resource "aws_route_table_association" "private_a_association" {
  subnet_id      = "${aws_subnet.private_a.id}"
  route_table_id = "${aws_route_table.private_traffic_a.id}"
}

resource "aws_route_table_association" "private_c_association" {
  subnet_id      = "${aws_subnet.private_c.id}"
  route_table_id = "${aws_route_table.private_traffic_c.id}"
}
