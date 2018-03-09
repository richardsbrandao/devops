resource "aws_instance" "batman_a" {
    ami = "${var.ec2_ami_instance}"
    instance_type = "${var.ec2_batman_instance_type}"
    associate_public_ip_address = true
    subnet_id = "${aws_subnet.public_a.id}"
    vpc_security_group_ids = [
        "${aws_security_group.sg_ssh.id}", 
        "${aws_security_group.sg_application.id}", 
        "${aws_security_group.sg_traffic.id}"
    ]
    key_name = "${var.key_pair_herotrip}"
    tags {
        Name = "Batman"
        Role = "Frontend"
    }
    user_data = "${file("${var.user_data_path}/batman.sh")}"
}

resource "aws_instance" "batman_b" {
    ami = "${var.ec2_ami_instance}"
    instance_type = "${var.ec2_batman_instance_type}"
    associate_public_ip_address = false
    subnet_id = "${aws_subnet.public_b.id}"
    vpc_security_group_ids = [
        "${aws_security_group.sg_ssh.id}", 
        "${aws_security_group.sg_application.id}", 
        "${aws_security_group.sg_traffic.id}"
    ]
    key_name = "${var.key_pair_herotrip}"
    tags {
        Name = "Batman"
        Role = "Frontend"
    }
    user_data = "${file("${var.user_data_path}/batman.sh")}"
}

resource "aws_instance" "superman_a" {
    ami = "${var.ec2_ami_instance}"
    instance_type = "${var.ec2_superman_instance_type}"
    associate_public_ip_address = false
    subnet_id = "${aws_subnet.private_a.id}"
    vpc_security_group_ids = [
        "${aws_security_group.sg_ssh.id}", 
        "${aws_security_group.sg_application.id}", 
        "${aws_security_group.sg_traffic.id}"
    ]
    key_name = "${var.key_pair_herotrip}"
    tags {
        Name = "Superman"
        Role = "Customer Management"
    }
    user_data = "${file("${var.user_data_path}/superman.sh")}"
}

resource "aws_instance" "superman_b" {
    ami = "${var.ec2_ami_instance}"
    instance_type = "${var.ec2_superman_instance_type}"
    associate_public_ip_address = false
    subnet_id = "${aws_subnet.private_b.id}"
    vpc_security_group_ids = [
        "${aws_security_group.sg_ssh.id}", 
        "${aws_security_group.sg_application.id}", 
        "${aws_security_group.sg_traffic.id}"
    ]
    key_name = "${var.key_pair_herotrip}"
    tags {
        Name = "Superman"
        Role = "Customer Management"
    }
    user_data = "${file("${var.user_data_path}/superman.sh")}"
}