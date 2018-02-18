provider "aws" { }

resource "aws_instance" "example" {
        ami = "ami-5ae1cb3f"
        instance_type = "t2.micro"
        tags {
         Name = "terraform-instance"
        }
}
