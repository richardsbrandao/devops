output "vpc_id" {
  value = "${aws_vpc.eks_vpc.id}"
}

output "private_a_subnet_id" {
  value = "${aws_subnet.private_a.id}"
}

output "private_c_subnet_id" {
  value = "${aws_subnet.private_c.id}"
}

output "public_a_subnet_id" {
  value = "${aws_subnet.public_a.id}"
}
