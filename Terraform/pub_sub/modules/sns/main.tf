resource "aws_sns_topic" "topic" {
    name = "${var.topic_name}"
    display_name = "${var.topic_name}"
}

resource "aws_sns_topic_subscription" "sqs" {
    topic_arn = "${aws_sns_topic.topic.arn}"
    protocol = "sqs"
    endpoint = "${var.sqs_arn}"
    endpoint_auto_confirms = true
}

resource "aws_sns_topic_subscription" "http" {
    topic_arn = "${aws_sns_topic.topic.arn}"
    protocol = "http"
    endpoint = "${var.http_endpoint}"
    endpoint_auto_confirms = true
}

resource "aws_sqs_queue_policy" "user_sqs_policy" {
  queue_url = "${var.sqs_id}"

  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Id": "sns-to-user-queue-sqspolicy",
  "Statement":[
    {
      "Sid":"SNSToSQSPolicy",
      "Effect":"Allow",
      "Principal":"*",
      "Action":"sqs:SendMessage",
      "Resource":"${var.sqs_arn}",
      "Condition":{
        "ArnEquals":{
          "aws:SourceArn": "${aws_sns_topic.topic.arn}"
        }
      }
    }
  ]
}
POLICY
}