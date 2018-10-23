resource "aws_sqs_queue" "dead_letter" {
  name = "${var.dead_letter_name}"
  message_retention_seconds = 345600 # 4 days

  tags {
    Name = "${var.dead_letter_name}"
  }
}

resource "aws_sqs_queue" "queue" {
  name = "${var.queue_name}"
  message_retention_seconds = 345600 # 4 days
  delay_seconds = 0
  redrive_policy = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.dead_letter.arn}\",\"maxReceiveCount\":100}"


  tags {
    Name = "${var.queue_name}"
  }
}
