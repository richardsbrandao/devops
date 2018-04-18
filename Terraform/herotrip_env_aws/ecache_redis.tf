resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name = "main"

  subnet_ids = [
    "${aws_subnet.private_a.id}",
    "${aws_subnet.private_b.id}",
  ]
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "herotrip-redis"                                          # var
  engine               = "redis"
  engine_version       = "3.2.10"                                                  # var
  maintenance_window   = "sun:05:00-sun:06:00"                                     # var
  node_type            = "cache.t2.small"
  num_cache_nodes      = "1"                                                       # var
  parameter_group_name = "default.redis3.2"
  port                 = "6379"
  subnet_group_name    = "${aws_elasticache_subnet_group.redis_subnet_group.name}"
  security_group_ids   = ["${aws_security_group.sg_redis.id}"]

  tags {
    Name = "Herotrip"
  }
}
