output "http_endpoint" {
  value = "${aws_instance.instance.public_ip}"
}
