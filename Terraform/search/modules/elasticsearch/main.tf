data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_elasticsearch_domain" "elasticsearch_domain" {
  domain_name = "${var.domain_name}"
  elasticsearch_version = "${var.elasticsearch_version}"
  cluster_config {
    instance_type = "${var.instance_type}"
    instance_count = "${var.instance_count}"
  }
  ebs_options = "${var.ebs_options}"
  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "es:*",
      "Principal": "*",
      "Effect": "Allow",
      "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain_name}/*",
      "Condition": {
        "IpAddress": {"aws:SourceIp": ["95.90.246.246/32"]}
      }
    }
  ]
}
POLICY
}

//http://checkip.amazonaws.com/
