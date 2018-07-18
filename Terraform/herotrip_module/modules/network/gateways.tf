# Ips
resource "aws_eip" "nat_eip_a" {
  vpc = true
}

resource "aws_eip" "nat_eip_c" {
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
  subnet_id     = "${aws_subnet.public_a.id}"
  depends_on    = ["aws_internet_gateway.gw"]
}

resource "aws_nat_gateway" "nat_public_c" {
  allocation_id = "${aws_eip.nat_eip_c.id}"
  subnet_id     = "${aws_subnet.public_c.id}"
  depends_on    = ["aws_internet_gateway.gw"]
}
