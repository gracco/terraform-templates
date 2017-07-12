resource "aws_alb" "alb_terraform" {
  name            = "${var.alb_name}-alb"
  internal        = false
  security_groups = ["${aws_security_group.default.id}"]
  subnets         = ["${var.subnets["ExternalSubnetA"]}","${var.subnets["ExternalSubnetB"]}"]
}

resource "aws_alb_target_group" "alb_terraform" {
  name     = "${var.alb_name}-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

}

resource "aws_alb_listener" "alb_terraform_443" {
  load_balancer_arn = "${aws_alb.alb_terraform.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.ssl_certificate}"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_terraform.arn}"
    type             = "forward"
  }
}


resource "aws_alb_target_group_attachment" "alb_terraform" {
  target_group_arn = "${aws_alb_target_group.alb_terraform.arn}"
  target_id        = "${element(aws_instance.default.*.id, count.index)}"
  port             = 80
  count = "${var.count}"
}
