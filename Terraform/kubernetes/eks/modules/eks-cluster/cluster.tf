resource "aws_eks_cluster" "cluster" {
  name     = "${var.cluster_name}"
  role_arn = "${aws_iam_role.cluster_role.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.cluster_eks.id}"]
    subnet_ids         = ["${var.private_a_subnet_id}", "${var.private_c_subnet_id}"]
  }
}