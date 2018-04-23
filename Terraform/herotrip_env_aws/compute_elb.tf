resource "aws_lb" "superman_elb" {
  load_balancer_type               = "application"
  name                             = "superman-elb"
  enable_cross_zone_load_balancing = true
  internal                         = true
  security_groups                  = ["${aws_security_group.sg_elb_superman.id}"]
  subnets                          = ["${aws_subnet.private_a.id}", "${aws_subnet.private_b.id}"]

  # access_logs { }
}

resource "aws_lb_target_group" "superman_target_group" {
  name                 = "superman-tg"
  vpc_id               = "${aws_vpc.herotrip.id}"
  port                 = "${var.superman_port}"
  protocol             = "${var.superman_protocol}"
  target_type          = "instance"
  deregistration_delay = 300

  health_check {
    interval            = "10"
    path                = "/api/v1/herotrip/service_check"
    port                = "${var.superman_port}"
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    timeout             = "5"
    matcher             = "200"
  }
}

resource "aws_lb_target_group_attachment" "superman_a" {
  target_group_arn = "${aws_lb_target_group.superman_target_group.arn}"
  target_id        = "${aws_instance.superman_a.id}"
  port             = "${var.superman_port}"
}

resource "aws_lb_target_group_attachment" "superman_b" {
  target_group_arn = "${aws_lb_target_group.superman_target_group.arn}"
  target_id        = "${aws_instance.superman_b.id}"
  port             = "${var.superman_port}"
}

resource "aws_lb_listener" "superman_http" {
  load_balancer_arn = "${aws_lb.superman_elb.arn}"
  port              = "${var.superman_port}"
  protocol          = "${var.superman_protocol}"

  default_action {
    target_group_arn = "${aws_lb_target_group.superman_target_group.arn}"
    type             = "forward"
  }
}
