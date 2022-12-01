module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.16.2"

  name        = "allow_http_to_lb"
  description = "Allow HTTP inbound traffic to ALB"
  vpc_id      = module.core_infra_network.vpc_id

  #   ingress {
  #     description      = "TLS from VPC"
  #     from_port        = 443
  #     to_port          = 443
  #     protocol         = "tcp"
  #     cidr_blocks      = ["10.0.0.0/16"]
  #   }

  #   egress {
  #     from_port        = 0
  #     to_port          = 0
  #     protocol         = "-1"
  #     cidr_blocks      = ["0.0.0.0/0"]
  #     #ipv6_cidr_blocks = ["::/0"]
  #   }

  ingress_cidr_blocks = ["10.10.0.0/16"]
  ingress_rules       = ["http-80-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "alb ingress ports"
      cidr_blocks = "10.10.0.0/16"
    }
  ]
  tags = {
    Name = "allow_http"
  }
}