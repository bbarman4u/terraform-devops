locals {
  target_group_config = {
    back-end-service-1-tg = {
      port        = 3570
      protocol    = "HTTP"
      target_type = "ip"
      health_check = {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        interval            = 60
        timeout             = 15
        port                = 3580
        path                = "/service1/smoketest"
        protocol            = "HTTP"
        matcher             = "200"
      }
      listener_rules = {
        priority     = 1
        path_pattern = "/service1*"
      }
    },
    back-end-service-2-tg = {
      port        = 3580
      protocol    = "HTTP"
      target_type = "ip"
      health_check = {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        interval            = 60
        timeout             = 15
        port                = 3640
        path                = "/service2/smoketest"
        protocol            = "HTTP"
        matcher             = "200"
      }
      listener_rules = {
        priority     = 2
        path_pattern = "/service1*"
      }
    },
    back-end-service-3-tg = {
      port        = 3590
      protocol    = "HTTP"
      target_type = "ip"
      health_check = {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        interval            = 90
        timeout             = 15
        port                = 3641
        path                = "/service3/smoketest"
        protocol            = "HTTP"
        matcher             = "200"
      }
      listener_rules = {
        priority     = 3
        path_pattern = "/service1*"
      }
    }
  }
}