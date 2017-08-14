resource "aws_vpc" "main" {
  cidr_block = "${var.cidr}"
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

resource "aws_default_network_acl" "public" {
  default_network_acl_id = "${aws_vpc.main.default_network_acl_id}"
  subnet_ids = [ "${aws_subnet.public.*.id}" ]
  ingress {
    rule_no = 100
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_block = "0.0.0.0/0"
    action = "allow"
  }
  ingress {
    rule_no = 101
    protocol = -1
    from_port = 0
    to_port = 0
    ipv6_cidr_block = "::/0"
    action = "allow"
  }
  egress {
    rule_no = 100
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_block = "0.0.0.0/0"
    action = "allow"
  }
  egress {
    rule_no = 101
    protocol = -1
    from_port = 0
    to_port = 0
    ipv6_cidr_block = "::/0"
    action = "allow"
  }
  tags {
    Name = "${var.name}-public"
  }
}

resource "aws_default_route_table" "public" {
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }
  tags {
    Name = "${var.name}-public"
  }
  depends_on = [ "aws_internet_gateway.main" ]
}

resource "aws_default_security_group" "allow_self" {
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    self = true
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
  tags {
    Name = "${var.name}-allow-self"
  }
}
