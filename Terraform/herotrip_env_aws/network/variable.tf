data "aws_availability_zones" "available" {}

variable "vpc_fullcidr" {
    default = "172.28.0.0/16"
    description = "VPC CIDIR BLOCK"
}

variable "subnet_cidr_public_a" {
    default = "172.28.0.0/24"
    description = "SUBNET PUBLIC A CIDIR BOCK"
}

variable "subnet_cidr_public_b" {
    default = "172.28.0.0/24"
    description = "SUBNET PUBLIC B CIDIR BOCK"
}

variable "subnet_cidr_private_a" {
    default = "172.28.0.0/24"
    description = "SUBNET PRIVATE A CIDIR BOCK"
}

variable "subnet_cidr_private_b" {
    default = "172.28.0.0/24"
    description = "SUBNET PRIVATE B CIDIR BOCK"
}