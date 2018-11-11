module "network" {
    source = "modules/network"

    environment = "${terraform.workspace}"

    vpc_name = "${terraform.workspace}-${var.vpc_suffix}"
    vpc_fullcidr = "${var.vpc_fullcidr}"

    subnet_public_a_cidr   = "${var.subnet_public_a_cidr}"
    subnet_public_c_cidr   = "${var.subnet_public_c_cidr}"
    subnet_private_a_cidr   = "${var.subnet_private_a_cidr}"
    subnet_private_c_cidr   = "${var.subnet_private_c_cidr}"
    
    availability_zone_a     = "${var.availability_zone_a}"
    availability_zone_c     = "${var.availability_zone_c}"
}

module "eks-cluster" {
  source = "modules/eks-cluster"

  environment = "${terraform.workspace}"
  cluster_name = "${terraform.workspace}-${var.cluster_suffix}"

  private_a_subnet_id = "${module.network.private_a_subnet_id}"
  private_c_subnet_id = "${module.network.private_c_subnet_id}"
  vpc_id = "${module.network.vpc_id}" 
}

module "eks-nodes" {
  source = "modules/eks-nodes"

  environment = "${terraform.workspace}"
  cluster_name = "${terraform.workspace}-${var.cluster_suffix}"
  workers_name = "${terraform.workspace}-${var.cluster_suffix}-node"
  cluster_endpoint = "${module.eks-cluster.cluster_endpoint}"
  cluster_certificate_authority_data = "${module.eks-cluster.cluster_certificate_authority_data}"


  private_a_subnet_id = "${module.network.private_a_subnet_id}"
  private_c_subnet_id = "${module.network.private_c_subnet_id}"
  vpc_id = "${module.network.vpc_id}" 
}

module "bastion" {
  source = "modules/bastion"

  environment                 = "${terraform.workspace}"
  name                        = "${terraform.workspace}-bastion"

  vpc_id                      = "${module.network.vpc_id}" 
  subnet_id                   = "${module.network.public_a_subnet_id}"
  ami                         = "ami-0bbe6b35405ecebdb"
  instance_type               = "t2.nano"
  associate_public_ip_address = true
  key_pair_name               = "kubernetes"
}

# network
variable "vpc_fullcidr" {}
variable "vpc_suffix" {}
variable "subnet_private_a_cidr" {}
variable "subnet_private_c_cidr" {}

variable "subnet_public_a_cidr" {}
variable "subnet_public_c_cidr" {}
variable "availability_zone_a" {}
variable "availability_zone_c" {}

# eks-cluster
variable "cluster_suffix" {}
