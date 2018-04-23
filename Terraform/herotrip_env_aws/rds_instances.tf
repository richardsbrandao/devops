resource "aws_db_subnet_group" "database_subnet_group" {
  name = "main"

  subnet_ids = [
    "${aws_subnet.private_a.id}",
    "${aws_subnet.private_b.id}",
  ]

  tags {
    Name = "Database Subnet Groups"
  }
}

resource "aws_db_instance" "mysql_instance" {
  allocated_storage       = "${var.allocated_storage}"
  backup_retention_period = "${var.backup_retention_period}"
  db_subnet_group_name    = "${aws_db_subnet_group.database_subnet_group.name}"
  engine                  = "${var.rds_engine}"
  engine_version          = "${var.rds_engine_version}"
  instance_class          = "${var.instance_class}"
  multi_az                = true
  identifier              = "herotrip-databases"
  name                    = "superman"
  username                = "root"
  password                = "herotrip"

  #password                 = "${trimspace(file("${path.module}/secrets/mydb1-password.txt"))}"
  port                   = "${var.rds_port}"
  publicly_accessible    = "${var.publicly_accessible}"
  storage_type           = "${var.storage_type}"
  vpc_security_group_ids = ["${aws_security_group.sg_mysql.id}"]
  skip_final_snapshot    = true

  tags {
    Name = "Mysql"
    Role = "CustomerManagement"
  }
}
