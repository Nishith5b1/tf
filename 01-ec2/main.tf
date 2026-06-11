resource "aws_instance" "instance_test" {
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t3.micro"
    
    tags = {
        Name = "terraform"
        Project = "roboshop"
        Environment = "dev"
    }

 vpc_security_group_ids = [aws_security_group.allow.id]

}

#It is crreated in default VPC
resource "aws_security_group" "allow" {

    name = "allow"
    description = "Allow all outbound traffic"

#outbound traffic
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "allow"
        Project = "roboshop"
        Environment = "dev"
    }
  
}