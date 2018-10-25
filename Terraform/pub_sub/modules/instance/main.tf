

resource "aws_instance" "instance" {
  ami                         = "ami-0f65671a86f061fcd"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = "subnet-51111a1b"

  vpc_security_group_ids = [
    "${aws_security_group.sg_pub_sub.id}",
  ]

  key_name = "pub_sub"

  tags {
    Name = "SQS/SNS"
  }
  user_data = "${file("${path.module}/user_data/user_data.sh")}"
}

resource "aws_security_group" "sg_pub_sub" {
  name        = "Pub-Sub"
  vpc_id      = "vpc-de34e0b7"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}