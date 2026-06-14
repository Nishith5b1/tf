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
  #records = [aws_instance.instance_test[index(var.instances, "frontend")].public_ip]
  records = [lookup(aws_instance.instance_test, "frontend").public_ip] # equivalent to aws_instance.instance_test["frontend"]
}

#contains - works on list, so conatins(keys(map), value) will convert map in to list and searches for value
#lookup - works on map, it takes input as map and key and get the value as output
#index - works on list, it takes list & value and get's the index number


#For list terraform creates

# aws_instance.instance_test[0] -> mongodb
# aws_instance.instance_test[1] -> redis
# aws_instance.instance_test[2] -> mysql
# ...
# aws_instance.instance_test[9] -> frontend

# For map terraform creates

# aws_instance.roboshop["mongodb"]
# aws_instance.roboshop["frontend"]

# Resources are indexed by KEY
# not by NUMBER