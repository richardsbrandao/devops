variable "environment" {
  description = "The name of the environment"
}

variable "vpc_id" {
  description = ""
}


variable "ec2_public_ami_instance" {
  description = ""
}
variable "ec2_public_instance_type" {
  description = ""
}
variable "ec2_private_ami_instance" {
  description = ""
}
variable "ec2_private_instance_type" {
  description = ""
}
variable "key_pair" {
  description = ""
}
variable "application_port" {
  description = ""
}


variable "subnet_public_a_id" {
  description = ""
}
variable "subnet_public_c_id" {
  description = ""
}
variable "subnet_private_a_id" {
  description = ""
}
variable "subnet_private_c_id" {
  description = ""
}