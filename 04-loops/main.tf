resource "aws_instance" "instance_test" {
  count = 4
  ami           = var.ami_id
  instance_type = var.environment == "dev" ? "t3.micro" : "t3.small" 
  tags          = {
    Name = "${var.Project}-${var.environment}-${var.instances[count.index]}"
  }

  vpc_security_group_ids = [aws_security_group.allow[count.index].id, aws_security_group.common.id]

}

#It is crreated in default VPC
resource "aws_security_group" "allow" {
  count = 4
  name        = "${var.Project}-${var.environment}-${var.instances[count.index]}"
  description = var.sg_name

  #outbound traffic
  egress {
    from_port   = var.port
    to_port     = var.port
    protocol    = var.protocol
    cidr_blocks = var.cidr
  }

  tags = {
      Name = "${var.Project}-${var.environment}-${var.instances[count.index]}"
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
}