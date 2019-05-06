module "serie_a_dynamotable" {
  source = "modules/dynamodb"

  table_name = "serie_a_history"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "id"
  hash_key_type = "S"

  lambda_filename = "codes/lambda_dynamo_to_elasticsearch/dynamo_to_elasticsearch.zip"
  lambda_name = "serie_a_dynamodb_event"
  lambda_runtime = "nodejs8.10"
}
