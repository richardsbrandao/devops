resource "aws_vpc" "herotrip" {
    cidr_block = "${var.vpc_fullcidr}"
    enable_dns_support = true 
    enable_dns_hostnames = true
    tags {
        Name = "HEROTRIP VPC"
    }
}