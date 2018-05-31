resource "aws_cloudwatch_metric_alarm" "superman_high_cpu_alarm" {
  alarm_name          = "scale_out_superman_cpu_alarm"
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
  alarm_actions     = ["${aws_autoscaling_policy.superman_scale_out_policy.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "superman_low_cpu_alarm" {
  alarm_name          = "scale_in_superman_cpu_alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "20"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.superman.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization GT"
  alarm_actions     = ["${aws_autoscaling_policy.superman_scale_in_policy.arn}"]
}
