resource "aws_instance" "instance_test" {
  for_each = var.instances
  ami           = var.ami_id
  instance_type = each.value.instance_type
  tags          = {
    Name = "${var.Project}-${var.environment}-${each.key}"
  }

  vpc_security_group_ids = [aws_security_group.allow[each.key].id, aws_security_group.common.id]

}

#It is crreated in default VPC
resource "aws_security_group" "allow" {
  
  for_each = var.instances
  name        = "${var.Project}-${var.environment}-${each.key}"
  description = var.sg_name

  #outbound traffic
  egress {
    from_port   = var.port
    to_port     = var.port
    protocol    = var.protocol
    cidr_blocks = var.cidr
  }

  tags = {
      Name = "${var.Project}-${var.environment}-${each.key}"
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_security_group" "common" {
  name = "${var.Project}-${var.environment}-common"
  description = "common group"
  egress {

    to_port = var.port
    from_port = var.port
    protocol = var.protocol
    cidr_blocks = var.cidr
  }
  tags = {
    Name = "${var.Project}-{var.environment}-common"
  }

  lifecycle {
    create_before_destroy = true
  }
}