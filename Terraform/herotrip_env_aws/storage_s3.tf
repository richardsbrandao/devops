resource "aws_s3_bucket" "fighters" {
  bucket = "herotrip-fighters"
  acl    = "private"
}

resource "aws_s3_bucket_object" "uploads" {
  bucket = "${aws_s3_bucket.fighters.id}"
  key    = "uploads/"
  source = "/dev/null"
}

resource "aws_s3_bucket_object" "thumbnail" {
  bucket = "${aws_s3_bucket.fighters.id}"
  key    = "thumbnail/"
  source = "/dev/null"
}
