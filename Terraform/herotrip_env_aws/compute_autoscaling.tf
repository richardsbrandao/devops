# Lanch Configurations

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

# Groups

resource "aws_autoscaling_group" "batman" {
  name                 = "batman"
  max_size             = 5
  min_size             = 2
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
  max_size             = 6
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

# Autoscaling Policy

resource "aws_autoscaling_policy" "bataman_policy" {
  name        = "batman_thermostat"
  policy_type = "TargetTrackingScaling"

  autoscaling_group_name = "${aws_autoscaling_group.batman.name}"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 30.0
  }
}

resource "aws_autoscaling_policy" "superman_decrease_policy" {
  name                   = "superman_decrease_policy"
  policy_type            = "StepScaling"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_autoscaling_group.superman.name}"

  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_lower_bound = 30
  }
}

resource "aws_autoscaling_policy" "superman_increase_policy" {
  name                   = "superman_increase_policy"
  policy_type            = "StepScaling"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_autoscaling_group.superman.name}"

  step_adjustment {
    scaling_adjustment          = 1
    metric_interval_upper_bound = 30
  }
}

resource "aws_cloudwatch_metric_alarm" "superman_cpu_alarm" {
  alarm_name          = "superman_increase_cpu_alarm LT"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.superman.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization GT"
  alarm_actions     = ["${aws_autoscaling_policy.superman_increase_policy.arn}"]
}
