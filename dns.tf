resource "aws_route53_record" "default" {
  #Route53 create A entry for internal IP
  zone_id = "${var.route53_zone_id}"
    name = "${var.hostname}-0${count.index+1}.stg"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.default.*.private_ip, count.index)}"]

  count = "${var.count}"
}

resource "aws_route53_record" "external_ip" {
  #Route53 create A entry for internal IP
  zone_id = "${var.route53_zone_id}"
  name = "graphql-test.stg"
  type = "CNAME"
  ttl = "300"
  records = ["${aws_alb.alb_terraform.dns_name}"]
}
