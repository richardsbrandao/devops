data "template_file" "user_data" {
  template = "${file("${path.module}/user_data/default_setup.sh")}"
}
