resource "aws_network_acl" "ssh_web_traffic" {
    vpc_id = "${aws_vpc.herotrip.id}"
    subnet_ids = [
        "${aws_subnet.public_a.id}",
        "${aws_subnet.public_b.id}",
        "${aws_subnet.private_a.id}",
        "${aws_subnet.private_b.id}"
    ]
    egress {
        protocol = "-1"
        rule_no = 2
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    ingress {
        protocol = "-1"
        rule_no = 1
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    tags {
        Name = "Web Traffic for subnets"
        Description = "IN 80|443|22 && OUT 1024-65535"
    }
}



# resource "aws_network_acl_rule" "ssh_traffic_inbound" {
#     network_acl_id = "${aws_network_acl.ssh_web_traffic.id}"
#     rule_number = 100
#     egress = false
#     protocol = "tcp"
#     rule_action = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port = 22
#     to_port = 22
# }

# resource "aws_network_acl_rule" "web_traffic_inbound" {
#     network_acl_id = "${aws_network_acl.ssh_web_traffic.id}"
#     rule_number = 101
#     egress = false
#     protocol = "tcp"
#     rule_action = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port = 8080
#     to_port = 8085
# }

# resource "aws_network_acl_rule" "web_traffic_outbound" {
#     network_acl_id = "${aws_network_acl.ssh_web_traffic.id}"
#     rule_number = 102
#     egress = true
#     protocol = "tcp"
#     rule_action = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port = 1024
#     to_port = 65535
# }