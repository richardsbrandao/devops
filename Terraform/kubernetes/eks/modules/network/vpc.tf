resource "aws_vpc" "eks_vpc" {
  cidr_block = "${var.vpc_fullcidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.vpc_name}"
  }
}