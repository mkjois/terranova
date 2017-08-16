resource "aws_vpc" "main" {
  cidr_block = "${var.cidr}"
  enable_dns_support = true
  enable_dns_hostnames = true
  assign_generated_ipv6_cidr_block = true
  tags {
    Name = "${var.name}"
  }
}

resource "aws_default_vpc_dhcp_options" "amazon" {
  tags {
    Name = "${var.name}-amazon"
  }
}
