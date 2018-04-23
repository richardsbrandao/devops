data "aws_availability_zones" "available" {}

# network 

variable "vpc_fullcidr" {
  default     = "172.28.0.0/16"
  description = "VPC CIDIR BLOCK"
}

variable "subnet_cidr_public_a" {
  default     = "172.28.0.0/24"
  description = "SUBNET PUBLIC A CIDIR BOCK"
}

variable "subnet_cidr_public_b" {
  default     = "172.28.1.0/24"
  description = "SUBNET PUBLIC B CIDIR BOCK"
}

variable "subnet_cidr_private_a" {
  default     = "172.28.2.0/24"
  description = "SUBNET PRIVATE A CIDIR BOCK"
}

variable "subnet_cidr_private_b" {
  default     = "172.28.3.0/24"
  description = "SUBNET PRIVATE B CIDIR BOCK"
}

# ec2

variable "ec2_batman_instance_type" {
  default     = "t2.micro"
  description = "EC2 instance for batman services"
}

variable "ec2_superman_instance_type" {
  default     = "t2.micro"
  description = "EC2 instance for batman services"
}

variable "ec2_ami_instance" {
  default     = "ami-4e79ed36"
  description = "AMI for all services"
}

variable "key_pair_herotrip" {
  default     = "herotrip"
  description = "Generated key pair for instances"
}

variable "user_data_path" {
  default = "user_data"
}

# rds

variable "allocated_storage" {
  default     = 20
  description = "Allocated storage in GB"
}

variable "backup_retention_period" {
  default     = 7
  description = "Days retention for backup"
}

variable "engine" {
  default     = "mysql"
  description = "Database engine to use"
}

variable "engine_version" {
  default     = "5.6.39"
  description = "Version for choosen engine"
}

variable "instance_class" {
  default     = "db.t2.small"
  description = "Instance type of the RDS Instance"
}

variable "port" {
  default     = 3306
  description = "Database port"
}

variable "publicly_accessible" {
  default     = false
  description = "Access type"
}

variable "storage_type" {
  default     = "gp2"
  description = "Storage type (magnet/general purpose SSD/provisioned IOPS SSD)"
}

# application

variable "superman_protocol" {
  default     = "HTTP"
  description = "Superman default protocol"
}

variable "superman_port" {
  default     = 3100
  description = "Superman default application port"
}
