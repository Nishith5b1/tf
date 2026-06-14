resource "aws_route53_record" "roboshop" {
  
  for_each = aws_instance.instance_test
  zone_id = var.zone_id
  type = "A"
  name = "${each.key}-${var.environment}.${var.domain_name}"
  ttl = 1
  records = [aws_instance.instance_test[each.key].private_ip]
}

resource "aws_route53_record" "frontend" {
  count = contains(keys(var.instances), "frontend") ? 1: 0 #This will convert map in to list for keys(var.instances)
  name = "${var.Project}-${var.environment}.${var.domain_name}"
  type = "A"
  zone_id = var.zone_id
  ttl = 1
  records = [lookup(aws_instance.instance_test, "frontend").public_ip] # equivalent to aws_instance.instance_test["frontend"]
}