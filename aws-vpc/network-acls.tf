resource "aws_network_acl" "private" {
  vpc_id = "${aws_vpc.main.id}"
  subnet_ids = [ "${aws_subnet.private.*.id}" ]
  tags {
    Name = "${var.name}-private"
  }
}

resource "aws_network_acl_rule" "private_ingress_all_ipv4" {
  network_acl_id = "${aws_network_acl.private.id}"
  rule_number = 100
  egress = false
  protocol = "-1"
  cidr_block = "0.0.0.0/0"
  rule_action = "allow"
}

resource "aws_network_acl_rule" "private_ingress_all_ipv6" {
  network_acl_id = "${aws_network_acl.private.id}"
  rule_number = 101
  egress = false
  protocol = "-1"
  ipv6_cidr_block = "::/0"
  rule_action = "allow"
}

resource "aws_network_acl_rule" "private_egress_all_ipv4" {
  network_acl_id = "${aws_network_acl.private.id}"
  rule_number = 100
  egress = true
  protocol = "-1"
  cidr_block = "0.0.0.0/0"
  rule_action = "allow"
}

resource "aws_network_acl_rule" "private_egress_all_ipv6" {
  network_acl_id = "${aws_network_acl.private.id}"
  rule_number = 101
  egress = true
  protocol = "-1"
  ipv6_cidr_block = "::/0"
  rule_action = "allow"
}

resource "aws_network_acl" "spare" {
  vpc_id = "${aws_vpc.main.id}"
  subnet_ids = [ "${aws_subnet.spare.*.id}" ]
  tags {
    Name = "${var.name}-reserved"
  }
}
