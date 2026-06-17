variable "ingress_rules" {

    type= map
    default = {
        ssh = {
            port = 22
            cidr_blocks = ["0.0.0.0/0", "10.0.0.0/32"]
        }
        http ={
            port = 80
            cidr_blocks = ["0.0.0.0/0"]
        }

        mysql ={
            port = 3306
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}