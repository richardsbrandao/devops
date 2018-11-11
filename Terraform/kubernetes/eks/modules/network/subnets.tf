data "aws_availability_zone" "us_west_2_a" {
  name = "us-west-2a"
}

data "aws_availability_zone" "us_west_2_c" {
  name = "us-west-2c"
}

resource "aws_subnet" "public_a" {
    vpc_id = "${aws_vpc.eks_vpc.id}"
    cidr_block = "${var.subnet_public_a_cidr}"
    availability_zone = "${data.aws_availability_zone.us_west_2_a.id}"

    tags {
        Name = "Public A"
        Environment = "${var.environment}"
    }
}

resource "aws_subnet" "public_c" {
    vpc_id = "${aws_vpc.eks_vpc.id}"
    cidr_block = "${var.subnet_public_c_cidr}"
    availability_zone = "${data.aws_availability_zone.us_west_2_c.id}"

    tags {
        Name = "Public C"
        Environment = "${var.environment}"
    }
}

resource "aws_subnet" "private_a" {
    vpc_id = "${aws_vpc.eks_vpc.id}"
    cidr_block = "${var.subnet_private_a_cidr}"
    availability_zone = "${data.aws_availability_zone.us_west_2_a.id}"

    tags {
        Name = "Private A"
        Environment = "${var.environment}"
    }
}

resource "aws_subnet" "private_c" {
    vpc_id = "${aws_vpc.eks_vpc.id}"
    cidr_block = "${var.subnet_private_c_cidr}"
    availability_zone = "${data.aws_availability_zone.us_west_2_c.id}"

    tags {
        Name = "Private C"
        Environment = "${var.environment}"
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
