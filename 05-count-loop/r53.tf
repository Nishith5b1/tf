resource "aws_route53_record" "roboshop" {
  count = length(var.instances)
  zone_id = var.zone_id
  type = "A"
  name = "${var.instances[count.index]}-${var.environment}.${var.domain_name}"
  ttl = 1
  records = [aws_instance.instance_test[count.index].private_ip]
}

resource "aws_route53_record" "frontend" {
  count = contains(var.instances, "frontend") ? 1: 0
  name = "${var.Project}-${var.environment}.${var.domain_name}"
  type = "A"
  zone_id = var.zone_id
  ttl = 1
  records = [aws_instance.instance_test[index(var.instances, "frontend")].public_ip]
}