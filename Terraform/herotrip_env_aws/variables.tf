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
    default = "172.28.1.0/24"
    description = "SUBNET PUBLIC B CIDIR BOCK"
}

variable "subnet_cidr_private_a" {
    default = "172.28.2.0/24"
    description = "SUBNET PRIVATE A CIDIR BOCK"
}

variable "subnet_cidr_private_b" {
    default = "172.28.3.0/24"
    description = "SUBNET PRIVATE B CIDIR BOCK"
}

variable "ec2_batman_instance_type" {
    default = "t2.micro"
    description = "EC2 instance for batman services"
}

variable "ec2_superman_instance_type" {
    default = "t2.micro"
    description = "EC2 instance for batman services"
}

variable "ec2_ami_instance" {
    default = "ami-5ae1cb3f"
    description = "AMI for all services"
}

variable "key_pair_herotrip" {
    default = "herotrip"
    description = "Generated key pair for instances"
}

# User Datas
variable "user_data_path" {
    default = "user_data"
}