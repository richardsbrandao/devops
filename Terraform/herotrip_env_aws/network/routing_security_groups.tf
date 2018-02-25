resource "aws_security_group" "sg_ssh" {
    name = "SSH"
    tags {
        name = "SSH"
        Role = "Enable SSH Connections"
    }
    description = "Onlyssh port enable"
    vpc_id = "${aws_vpc.herotrip.id}"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "sg_batman" {
    name = "Batman"
    tags {
        name = "Batman"
        Role = "Frontend"
    }
    description = "Only service port enable"
    vpc_id = "${aws_vpc.herotrip.id}"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "sg_superman" {
    name = "Superman"
    tags {
        Name = "Superman"
        Role = "Customer Management"
    }
    description = "Only service port enable"
    vpc_id = "${aws_vpc.herotrip.id}"

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["${var.subnet_cidr_public_a}", "${var.subnet_cidr_public_b}"]
    }
}

resource "aws_security_group" "sg_thor" {
    name = "Thor"
    tags = {
        Name = "Thor"
        Role = "Money Management"
    }
    description = "Only service port enable"
    vpc_id = "${aws_vpc.herotrip.id}"
    
    ingress {
        from_port = 8083
        to_port = 8083
        protocol = "tcp"
        cidr_blocks = ["${var.subnet_cidr_public_a}", "${var.subnet_cidr_public_b}"]
    }
}

resource "aws_security_group" "sg_ironman" {
    name = "Ironman"
    tags = {
        Name = "Ironman"
        Role = "Wallet Management"
    }
    description = "Only service port enable"
    vpc_id = "${aws_vpc.herotrip.id}"

    ingress {
        from_port = 8082
        to_port = 8082
        protocol = "tcp"
        cidr_blocks = ["${var.subnet_cidr_public_a}", "${var.subnet_cidr_public_b}"]
    }
}

resource "aws_security_group" "sg_captainamerica" {
    name = "CaptainAmerica"
    tags = {
        Name = "Thor"
        Role = "Places Management"
    }
    description = "Only service port enable"
    vpc_id = "${aws_vpc.herotrip.id}"

    ingress {
        from_port = 8081
        to_port = 8081
        protocol = "tcp"
        cidr_blocks = ["${var.subnet_cidr_public_a}", "${var.subnet_cidr_public_b}"]
    }
}

resource "aws_security_group" "sg_greenarrow" {
    name = "GreenArrow"
    tags = {
        Name = "GreenArrow"
        Role = "Social Features"
    }
    description = "Only service port enable"
    vpc_id = "${aws_vpc.herotrip.id}"

    ingress {
        from_port = 8084
        to_port = 8084
        protocol = "tcp"
        cidr_blocks = ["${var.subnet_cidr_public_a}", "${var.subnet_cidr_public_b}"]
    }
}

resource "aws_security_group" "sg_xavier" {
    name = "Xavier"
    tags = {
        Name = "Xavier"
        Role = "Currency Management"
    }
    description = "Only service port enable"
    vpc_id = "${aws_vpc.herotrip.id}"

    ingress {
        from_port = 8085
        to_port = 8085
        protocol = "tcp"
        cidr_blocks = ["${var.subnet_cidr_public_a}", "${var.subnet_cidr_public_b}"]
    }
}