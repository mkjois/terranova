resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"
  tags {
    Name = "${var.name}-private"
  }
}

resource "aws_route" "private_all_ipv4" {
  route_table_id = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${element(aws_nat_gateway.main.*.id, var.ngw_primary)}"
}

resource "aws_route" "private_all_ipv6" {
  route_table_id = "${aws_route_table.private.id}"
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id = "${aws_egress_only_internet_gateway.main.id}"
}

resource "aws_route_table_association" "private" {
  count = "${length(aws_subnet.private.*.id)}"
  subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "public" {
  count = "${length(aws_subnet.public.*.id)}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_default_route_table.public.id}"
}

resource "aws_route_table" "spare" {
  vpc_id = "${aws_vpc.main.id}"
  tags {
    Name = "${var.name}-reserved"
  }
}

resource "aws_route_table_association" "spare" {
  count = "${length(aws_subnet.spare.*.id)}"
  subnet_id = "${element(aws_subnet.spare.*.id, count.index)}"
  route_table_id = "${aws_route_table.spare.id}"
}
