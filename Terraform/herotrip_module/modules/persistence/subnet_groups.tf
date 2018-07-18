resource "aws_db_subnet_group" "database_subnet_group" {
  name = "main"

  subnet_ids = [
    "${var.subnet_db_a_id}",
    "${var.subnet_db_c_id}",
  ]

  tags {
    Name = "Database Subnet Groups"
  }
}