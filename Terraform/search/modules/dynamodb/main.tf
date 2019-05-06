resource "aws_dynamodb_table" "table" {
  "attribute" {
    name = "${var.hash_key}"
    type = "${var.hash_key_type}"
  }

  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  hash_key = "${var.hash_key}"
  name = "${var.table_name}"
  billing_mode = "${var.billing_mode}"
}

//<<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Action": [
//        "dynamodb:GetRecords",
//        "dynamodb:GetShardIterator",
//        "dynamodb:DescribeStream",
//        "dynamodb:ListStreams"
//      ],
//      "Effect": "Allow",
//      "Principal": {
//        "Resource": "${aws_dynamodb_table.table.arn}"
//      }
//    },
//    {
//      "Action": [
//        "logs:CreateLogGroup",
//         "logs:CreateLogStream",
//         "logs:PutLogEvents"
//      ],
//      "Effect": "Allow",
//      "Principal": {
//        "Resource": "arn:aws:logs:*:*:*"
//      }
//    }
//  ]
//}
//EOF

//data "aws_iam_role" "role_dynamo_lambda" {
//  name = "test-role"
//}

data "aws_iam_policy_document" "policy_dynamo_lambda"{
  statement {
    actions =  ["sts:AssumeRole"],
    principals {
      type = "Service"
      identifiers = [
        "dynamodb.amazonaws.com",
        "lambda.amazonaws.com",
        "logs.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy" "dynamo-lambda-policy" {
  name = "elliodr-user-added-lambda-iam-role-policy"
  role = "${aws_iam_role.role_dynamo_lambda.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:GetRecords",
        "dynamodb:GetShardIterator",
        "dynamodb:DescribeStream",
        "dynamodb:ListStreams"
      ],
      "Effect": "Allow",
      "Resource": "${aws_dynamodb_table.table.arn}/*"
    },
    {
      "Action": [
         "logs:CreateLogGroup",
         "logs:CreateLogStream",
         "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "role_dynamo_lambda" {
  name = "role-dynamo-lambda"
  assume_role_policy = "${data.aws_iam_policy_document.policy_dynamo_lambda.json}"
}

resource "aws_lambda_function" "lambda" {
  function_name = "${var.lambda_name}"
  filename = "${var.lambda_filename}"
  handler = "dynamo_to_elasticsearch.handler"
  role = "${aws_iam_role.role_dynamo_lambda.arn}"
//  role = "${data.aws_iam_role.role_dynamo_lambda.arn}"
  runtime = "${var.lambda_runtime}"
}

resource "aws_lambda_event_source_mapping" "dynamo_lambda_event" {
  batch_size = 100
  event_source_arn = "${aws_dynamodb_table.table.stream_arn}"
  function_name = "${aws_lambda_function.lambda.function_name}"
  enabled = true
  starting_position = "LATEST"
}
//arn:aws:dynamodb:eu-west-1:051129233020:table/serie_a_history
