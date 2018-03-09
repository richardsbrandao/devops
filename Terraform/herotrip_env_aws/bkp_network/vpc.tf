resource "aws_vpc" "herotrip" {
    cidr_block = "${var.vpc_fullcidr}"
    # disable public ip and hostnames
    enable_dns_support = false 
    enable_dns_hostnames = false
    tags {
        Name = "HEROTRIP VPC"
    }
}