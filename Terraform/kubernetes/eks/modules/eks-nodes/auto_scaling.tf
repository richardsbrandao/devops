resource "aws_launch_configuration" "worker_launch_configuration" {
  iam_instance_profile        = "${aws_iam_instance_profile.workers_instance_profile.name}"
  #image_id                    = "${data.aws_ami.eks_worker_ami.id}"
  image_id                    = "ami-0a54c984b9f908c81"
  instance_type               = "t2.medium"
  name_prefix                 = "${var.workers_name}"
  security_groups             = ["${aws_security_group.workers_eks.id}"]
  user_data                   = "${data.template_file.workers_user_data.rendered}"
  key_name                    = "kubernetes"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "worker_auto_scaling" {
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.worker_launch_configuration.id}"
  max_size             = 5
  min_size             = 1
  name                 = "terraform-eks-demo"
  vpc_zone_identifier  = [
    "${var.private_a_subnet_id}",
    "${var.private_c_subnet_id}"
  ]

  tag {
    key                 = "Name"
    value               = "${var.workers_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }
}

data "aws_ami" "eks_worker_ami" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

data "template_file" "workers_user_data" {
  template = "${file("${path.module}/user_datas/workers_user_data.tpl")}"
  
  vars {
    CLUSTER_ENDPOINT = "${var.cluster_endpoint}"
    CERTIFICATE_AUTHORITY_DATA = "${var.cluster_certificate_authority_data}"
    CLUSTER_NAME = "${var.cluster_name}"
  }
}