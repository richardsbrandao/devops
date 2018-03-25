resource "aws_elb" "elb_superman" {
  name = "elb-superman"

  instances                 = ["${aws_instance.superman_a.id}", "${aws_instance.superman_b.id}"]
  security_groups           = ["${aws_security_group.sg_elb_superman.id}"]
  subnets                   = ["${aws_subnet.private_a.id}", "${aws_subnet.private_b.id}"]
  cross_zone_load_balancing = true
  internal                  = true

  # access log no s3

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/service_check"
    interval            = "10"
  }
  tags {
    Name = "Superman"
    Role = "Customer Management"
  }
}
