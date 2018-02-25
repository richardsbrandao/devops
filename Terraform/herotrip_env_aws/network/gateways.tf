# Ips
resource "aws_eip" "nat_eip_a" {
    vpc = true
}

resource "aws_eip" "nat_eip_b" {
    vpc = true
}

# Gateways
resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.herotrip.id}"
    tags {
        Name = "INTERNET GATEWAY HEROTRIP"
    }
}

resource "aws_nat_gateway" "nat_public_a" {
    allocation_id = "${aws_eip.nat_eip_a.id}"
    subnet_id = "${aws_subnet.public_a.id}"
    depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_nat_gateway" "nat_public_b" {
    allocation_id = "${aws_eip.nat_eip_b.id}"
    subnet_id = "${aws_subnet.public_b.id}"
    depends_on = ["aws_internet_gateway.gw"]
}