resource "aws_dynamodb_table" "table" {
  "attribute" {
    name = "${var.hash_key}"
    type = "${var.hash_key_type}"
  }
  hash_key = "${var.hash_key}"
  name = "${var.table_name}"
  billing_mode = "${var.billing_mode}"
}
