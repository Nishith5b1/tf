resource "aws_instance" "dynamic" {
  
  ami = "ami-0220d79f3f480ecf5"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.allow.id]
  
  tags = {
    Name = "dynamic"
    Project = "roboshop"
    Environment = "dev"
  }
}

resource "aws_security_group" "allow" {
  
  name = "allow_terraform_dynamic"
  description = " dynamic loop"

  egress {

    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]

  }
  # ingress block
  # this give us special vairable ingress
  dynamic "ingress" {

    for_each = var.ingress_rules
    content {
      from_port = ingress.value.port
      to_port = ingress.value.port
      protocol = "tcp"
      cidr_blocks = ingress.value.cidr_blocks
    }
    
  }
    tags = {
    Name = "allow_terraform"
    Project = "roboshop"
    Environment = "dev"
    }

}