resource "aws_subnet" "PublicA" {
    vpc_id = "${aws_vpc.herotrip.id}"
    cidr_block = "${var.subnet_cidr_public_a}"
    tags {
        Name = "PublicA"
    }
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
}

resource "aws_subnet" "PublicB" {
    vpc_id = "${aws_vpc.herotrip.id}"
    cidr_block = "${var.subnet_cidr_public_b}"
    tags {
        Name = "PublicB"
    }
    availability_zone = "${data.aws_availability_zones.available.names[1]}"
}

resource "aws_subnet" "PrivateA" {
    vpc_id = "${aws_vpc.herotrip.id}"
    cidr_block = "${var.subnet_cidr_private_a}"
    tags {
        Name = "PrivateA"
    }
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
}

resource "aws_subnet" "PrivateB" {
    vpc_id = "${aws_vpc.herotrip.id}"
    cidr_block = "${var.subnet_cidr_private_b}"
    tags {
        Name = "PrivateB"
    }
    availability_zone = "${data.aws_availability_zones.available.names[1]}"
}