provider "aws" {}

module "hello_world" {
    source = "modules/sqs"

    queue_name = "${var.hello_world_queue_name}"
    dead_letter_name = "${var.hello_world_dead_letter_name}"
}

module "hello_sns" {
    source = "modules/sns"

    topic_name = "${var.hello_world_queue_name}"
    sqs_arn = "${module.hello_world.queue_arn}"
    sqs_id = "${module.hello_world.queue_id}"
    http_endpoint = "http://${module.instance.http_endpoint}/sns"
}

module "instance" {
    source = "modules/instance"
}