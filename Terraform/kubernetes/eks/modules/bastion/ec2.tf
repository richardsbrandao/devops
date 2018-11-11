resource "aws_instance" "bastion" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    associate_public_ip_address = "${var.associate_public_ip_address}"
    subnet_id = "${var.subnet_id}"
    vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
    key_name = "${var.key_pair_name}"

    tags {
        Name = "${var.name}"
    }
}
