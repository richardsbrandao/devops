resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name = "main"

  subnet_ids = [
    "${aws_subnet.private_a.id}",
    "${aws_subnet.private_b.id}",
  ]
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.cluster_id}"
  engine               = "${var.ecache_engine}"
  engine_version       = "${var.ecache_engine_version}"
  maintenance_window   = "${var.maintenance_window}"
  node_type            = "${var.node_type}"
  num_cache_nodes      = "${var.num_cache_nodes}"
  parameter_group_name = "${var.group_name}"
  port                 = "${var.ecache_port}"
  subnet_group_name    = "${aws_elasticache_subnet_group.redis_subnet_group.name}"
  security_group_ids   = ["${aws_security_group.sg_redis.id}"]

  tags {
    Name = "Herotrip"
  }
}
