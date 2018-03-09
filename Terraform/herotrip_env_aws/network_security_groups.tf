resource "aws_security_group" "sg_ssh" {
    name = "Ssh"
    description = "Enable SSH Connections"
    vpc_id = "${aws_vpc.herotrip.id}"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "sg_application" {
    name = "Application"
    description = "Enable Only Applications Port"
    vpc_id = "${aws_vpc.herotrip.id}"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8085
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "sg_traffic" {
    name =  "Leave Traffic"
    description = "Enable traffic to leave"
    vpc_id = "${aws_vpc.herotrip.id}"
    egress {
        from_port = 0
        to_port  = 0
        protocol  = "-1"
        cidr_blocks  = ["0.0.0.0/0"]
    }
}