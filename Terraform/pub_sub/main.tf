provider "aws" {}

module "hello_world" {
    source = "modules/sqs"

    queue_name = "${var.hello_world_queue_name}"
    dead_letter_name = "${var.hello_world_dead_letter_name}"
}