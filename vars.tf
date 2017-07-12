variable "route53_zone_id" {
  description = "Route53 zone ID"
  default = "ACMECORPORATIONLIMITED"
}

variable "vpc_id" {
  description = "VPC ID"
  default = "vpc-acme"
}

variable "aws_region" {
  description = "AWS Region"
  default = "us-west-2"
}

variable "hostname" {
  description = "Server hostname, and its used as key name in some tags"
  default = "acme-frontend"
}

variable "alb_name" {
  description = "Application load balancer tag name, ALB has some rules for names"
  default = "acme-alb"
}

variable "instance_type" {
  description = "Instance type"
  default = "t2.small"
}

variable "user" {
  default = "ubuntu"
}

variable "ami" {
  description = "AMI, this one it's for Ubuntu 16.04"
  default = "ami-a58d0dc5"
}

variable "key_name" {
  description = "Our ssh public key"
  default = "acmesshkey"
}

variable "subnets" {
  type        = "map"
  default     = {
    InternalSubnetA  = "subnet-internalacmeA"
    ExternalSubnetA = "subnet-externalacmeA"
    InternalSubnetB  = "subnet-internalacmeB"
    ExternalSubnetB = "subnet-externalacmeB"
  }
}

variable "ssl_certificate" {
  default = "arn:aws:acm:us-west-2:acme:ssl:certificate:addinyourawsaccount"
}

variable "count" {
  description = "Number of hosts"
  default = "2"
}
