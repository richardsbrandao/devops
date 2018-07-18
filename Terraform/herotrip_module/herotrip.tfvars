environment = "staging"

#Network
vpc_name = "herotrip"
vpc_fullcidr = "10.22.0.0/16"

subnet_public_a_cidr  = "10.22.0.0/28"
subnet_public_c_cidr  = "10.22.1.0/28"
subnet_private_a_cidr = "10.22.0.32/28"
subnet_private_c_cidr = "10.22.1.32/28"
subnet_db_a_cidr = "10.22.0.48/28"
subnet_db_c_cidr = "10.22.1.48/28"

availability_zone_a = "us-west-2a"
availability_zone_c = "us-west-2c"

#RDS
allocated_storage = 20
backup_retention_period = 7
rds_engine = "mysql"
rds_engine_version = "5.6.39"
instance_class = "db.t2.micro"
rds_port = 3306
publicly_accessible = false
storage_type = "gp2"

#Compute
ec2_public_ami_instance = "ami-4e79ed36"
ec2_public_instance_type = "t2.micro"
ec2_private_ami_instance = "ami-4e79ed36"
ec2_private_instance_type = "t2.micro"
key_pair = "herotrip"
application_port = 8080