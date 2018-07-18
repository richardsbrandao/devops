# Lanch Configurations

resource "aws_launch_configuration" "public_asg" {
  name                        = "batman_template"
  image_id                    = "${var.ec2_public_ami_instance}"
  instance_type               = "${var.ec2_public_instance_type}"
  key_name                    = "${var.key_pair}"
  security_groups             = ["${aws_security_group.sg_application.id}"]
  associate_public_ip_address = true

  user_data = "${data.template_file.user_data.rendered}"

  root_block_device {
    delete_on_termination = "1"
    volume_type           = "gp2"
  }
}

resource "aws_launch_configuration" "private_asg" {
  name                        = "superman_template"
  image_id                    = "${var.ec2_private_ami_instance}"
  instance_type               = "${var.ec2_private_instance_type}"
  key_name                    = "${var.key_pair}"
  security_groups             = ["${aws_security_group.sg_application.id}"]
  associate_public_ip_address = false

  user_data = "${data.template_file.user_data.rendered}"

  root_block_device {
    delete_on_termination = "1"
    volume_type           = "gp2"
  }
}

# Groups

resource "aws_autoscaling_group" "public_asg" {
  name                 = "batman"
  max_size             = 5
  min_size             = 2
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.public_asg.id}"
  vpc_zone_identifier  = ["${var.subnet_public_a_id}", "${var.subnet_public_c_id}"]

  tags = [
    {
      key                 = "Name"
      value               = "Public ${var.environment}"
      propagate_at_launch = true
    }
  ]
}

resource "aws_autoscaling_group" "private_asg" {
  name                 = "superman"
  max_size             = 6
  min_size             = 2
  desired_capacity     = 2
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.private_asg.id}"
  vpc_zone_identifier  = ["${var.subnet_private_a_id}", "${var.subnet_private_a_id}"]

  tags = [
    {
      key                 = "Name"
      value               = "Private ${var.environment}"
      propagate_at_launch = true
    }
  ]
}