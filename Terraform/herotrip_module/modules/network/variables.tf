variable "environment" {
  description = "The name of the environment"
}

variable "vpc_fullcidr" {
  description = "Th vpc CIDR Block"
}

variable "vpc_name" {
  description = "The name of VPC"
}

variable "subnet_public_a_cidr" {
  description = "The subnet Public A CIDR Block"
}

variable "subnet_public_c_cidr" {
  description = "The subnet Public C CIDR Block"
}

variable "subnet_private_a_cidr" {
  description = "The subnet Private A CIDR Block"
}

variable "subnet_private_c_cidr" {
  description = "The subnet Private C CIDR Block"
}

variable "subnet_db_a_cidr" {
  description = "The subnet DB A CIDR Block"
}

variable "subnet_db_c_cidr" {
  description = "The subnet DB C CIDR Block"
}

variable "availability_zone_a" {
  description = "The AZ A"
}

variable "availability_zone_c" {
  description = "The AZ C"
}