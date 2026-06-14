variable "ami_id" {
  type        = string
  default     = "ami-0220d79f3f480ecf5"
  description = "RHEL9 image"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "type of the instance"
  validation {
    condition = contains(["t3.micro", "t3.small"], var.instance_type)
    error_message = "instance_type must be either t3.micro or t3.small"
  }

}

variable "environment" {
  type = string
  default = "dev"
}

# variable "ec2_tags" {
#   type = map(any)

#   default = {
#     Name        = "terraform"
#     Project     = "roboshop"
#     Environment = "dev"
#   }

# }

variable "sg_name" {

  type    = string
  default = "allow"

}

variable "port" {
  type    = number
  default = 0

}

variable "protocol" {
  type    = number
  default = -1

}

variable "cidr" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

# variable "sg_tags" {
#   type = map(any)
#   default = {
#     Name        = "allow_terraform"
#     Project     = "roboshop"
#     Environment = "dev"
#   }
# }

variable "instances" {

  type = map
  default = {
    mongodb = {
      "instance_type" = "t3.micro"
    },
    redis = {
      "instance_type" = "t3.micro"
    },
    mysql = {
      "instance_type" = "t3.micro"
    },
    rabbitmq = {
      "instance_type" = "t3.micro"
    },
    catalogue = {
      "instance_type" = "t3.micro"
    },
    user = {
      "instance_type" = "t3.micro"
    },
    cart = {
      "instance_type" = "t3.micro"
    },
    shipping = {
      "instance_type" = "t3.micro"
    },
    payment = {
      "instance_type" = "t3.micro"
    },
    frontend = {
      "instance_type" = "t3.micro"
    }
  }
}

variable zone_id {

    default = "Z0242713Y3CVTBS0RZKI"
    description = "r53 zone id"
}

variable domain_name {

    default = "adrith.shop"
    description = "Zone name"
}

variable "Project" {
    type =  string
    default = "roboshop"
  
}