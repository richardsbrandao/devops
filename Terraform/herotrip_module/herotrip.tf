module "network" {
  source = "modules/network"

  environment             = "${var.environment}"
  vpc_name                = "${var.vpc_name}"
  vpc_fullcidr            = "${var.vpc_fullcidr}"

  subnet_public_a_cidr   = "${var.subnet_public_a_cidr}"
  subnet_public_c_cidr   = "${var.subnet_public_c_cidr}"
  subnet_private_a_cidr   = "${var.subnet_private_a_cidr}"
  subnet_private_c_cidr   = "${var.subnet_private_c_cidr}"
  subnet_db_a_cidr = "${var.subnet_db_a_cidr}"
  subnet_db_c_cidr = "${var.subnet_db_c_cidr}"
  
  availability_zone_a     = "${var.availability_zone_a}"
  availability_zone_c     = "${var.availability_zone_c}"
}

module "persistence" {
  source = "modules/persistence"
  
  environment = "${var.environment}"

  vpc_fullcidr      = "${var.vpc_fullcidr}"
  vpc_id            = "${module.network.vpc_id}"
  subnet_db_a_id = "${module.network.subnet_db_a_id}"
  subnet_db_c_id = "${module.network.subnet_db_c_id}"

  allocated_storage = "${var.allocated_storage}"
  backup_retention_period = "${var.backup_retention_period}"
  rds_engine = "${var.rds_engine}"
  rds_engine_version = "${var.rds_engine_version}"
  instance_class = "${var.instance_class}"
  rds_port = "${var.rds_port}"
  publicly_accessible = "${var.publicly_accessible}"
  storage_type = "${var.storage_type}"
}

module "compute" {
  source = "modules/compute"

  environment = "${var.environment}"
  vpc_id = "${module.network.vpc_id}"
  subnet_public_a_id = "${module.network.subnet_public_a_id}"
  subnet_public_c_id = "${module.network.subnet_public_c_id}"
  subnet_private_a_id = "${module.network.subnet_private_a_id}"
  subnet_private_c_id = "${module.network.subnet_private_c_id}"

  ec2_public_ami_instance = "${var.ec2_public_ami_instance}"
  ec2_public_instance_type = "${var.ec2_public_instance_type}"
  ec2_private_ami_instance = "${var.ec2_private_ami_instance}"
  ec2_private_instance_type = "${var.ec2_private_instance_type}"
  key_pair = "${var.key_pair}"
  application_port = "${var.application_port}"
}

variable "environment" {}

variable "subnet_private_a_cidr" {}
variable "subnet_private_c_cidr" {}

variable "subnet_public_a_cidr" {}
variable "subnet_public_c_cidr" {}

variable "subnet_db_a_cidr" {}
variable "subnet_db_c_cidr" {}

variable "vpc_name" {}
variable "vpc_fullcidr" {}

variable "availability_zone_a" {}
variable "availability_zone_c" {}

variable "allocated_storage" {}
variable "backup_retention_period" {}
variable "rds_engine" {}
variable "rds_engine_version" {}
variable "instance_class" {}
variable "rds_port" {}
variable "publicly_accessible" {}
variable "storage_type" {}

variable "ec2_public_ami_instance" {}
variable "ec2_public_instance_type" {}
variable "ec2_private_ami_instance" {}
variable "ec2_private_instance_type" {}
variable "key_pair" {}
variable "application_port" {}
