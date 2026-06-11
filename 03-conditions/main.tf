resource "aws_instance" "instance_test" {
  ami           = var.ami_id
  instance_type = var.environment == "dev" ? "t3.micro" : "t3.small" 
  tags          = var.ec2_tags

  vpc_security_group_ids = [aws_security_group.allow.id]

}

#It is crreated in default VPC
resource "aws_security_group" "allow" {

  name        = var.sg_name
  description = var.sg_name

  #outbound traffic
  egress {
    from_port   = var.port
    to_port     = var.port
    protocol    = var.protocol
    cidr_blocks = var.cidr
  }

  tags = var.sg_tags

}