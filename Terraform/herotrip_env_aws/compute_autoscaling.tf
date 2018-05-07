resource "aws_launch_configuration" "batman" {
  name                        = "batman_template"
  image_id                    = "${var.ec2_ami_instance}"
  instance_type               = "${var.ec2_batman_instance_type}"
  key_name                    = "${var.key_pair_herotrip}"
  security_groups             = ["${aws_security_group.sg_herotrip.id}"]
  associate_public_ip_address = true

  #user_data = ""
  # iam_instance_profile = ""

  root_block_device {
    delete_on_termination = "1"
    volume_type           = "gp2"
  }
}

resource "aws_launch_configuration" "superman" {
  name                        = "superman_template"
  image_id                    = "${var.ec2_ami_instance}"
  instance_type               = "${var.ec2_superman_instance_type}"
  key_name                    = "${var.key_pair_herotrip}"
  security_groups             = ["${aws_security_group.sg_herotrip.id}"]
  associate_public_ip_address = false

  #user_data = ""
  # iam_instance_profile = ""

  root_block_device {
    delete_on_termination = "1"
    volume_type           = "gp2"
  }
}

resource "aws_autoscaling_group" "batman" {
  name                 = "batman"
  max_size             = 3
  min_size             = 2
  desired_capacity     = 2
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.batman.id}"
  vpc_zone_identifier  = ["${aws_subnet.public_a.id}", "${aws_subnet.public_b.id}"]

  tags = [
    {
      key                 = "Name"
      value               = "Batman"
      propagate_at_launch = true
    },
    {
      key                 = "Name"
      value               = "Frontend"
      propagate_at_launch = true
    },
  ]
}

resource "aws_autoscaling_group" "superman" {
  name                 = "superman"
  max_size             = 3
  min_size             = 2
  desired_capacity     = 2
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.superman.id}"
  vpc_zone_identifier  = ["${aws_subnet.private_a.id}", "${aws_subnet.private_b.id}"]

  tags = [
    {
      key                 = "Name"
      value               = "Superman"
      propagate_at_launch = true
    },
    {
      key                 = "Name"
      value               = "Backend"
      propagate_at_launch = true
    },
  ]
}
