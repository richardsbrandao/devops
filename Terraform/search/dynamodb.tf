module "serie_a_dynamotable" {
  source = "modules/dynamodb"

  table_name = "serie_a_history"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "id"
  hash_key_type = "S"
}
