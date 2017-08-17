/**
 * Public route table
 */

resource "aws_default_route_table" "public" {
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"
  tags {
    Name = "${var.name}-public"
  }
  depends_on = [ "aws_internet_gateway.main" ]
}

resource "aws_route_table_association" "public" {
  count = "${length(aws_subnet.public.*.id)}"
  subnet_id = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_default_route_table.public.id}"
}

resource "aws_route" "public_all_ipv4" {
  route_table_id = "${aws_default_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.main.id}"
}

resource "aws_route" "public_all_ipv6" {
  route_table_id = "${aws_default_route_table.public.id}"
  destination_ipv6_cidr_block = "::/0"
  gateway_id = "${aws_internet_gateway.main.id}"
}

/**
 * Private route table
 */

resource "aws_route_table" "private" {
  count = "${min(max(var.ngw_redundancy, 1), length(data.aws_availability_zones.all.names))}"
  vpc_id = "${aws_vpc.main.id}"
  tags {
    Name = "${var.name}-private${var.ngw_redundancy < 2 ? "" : format("-%d", count.index)}"
  }
}

resource "aws_route_table_association" "private" {
  count = "${length(aws_subnet.private.*.id)}"
  subnet_id = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_route" "private_all_ipv4" {
  count = "${min(max(var.ngw_redundancy, 0), length(data.aws_availability_zones.all.names))}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  /**
   * WHAT IS THIS BLACK MAGIC?
   *
   * let A = matchkeys(aws_subnet.public.*.id, aws_subnet.public.*.availability_zone, data.aws_availability_zones.available.names)
   * let B = matchkeys(aws_nat_gateway.main.*.id, aws_nat_gateway.main.*.subnet_id, A)
   * let nat_gateway_id = element(B, count.index)
   *
   * A) Public subnet IDs of subnets in AVAILABLE zones (as opposed to ALL zones)
   * B) NAT gateway IDs in the subnets from (A)
   *
   * The effect is to distribute the egress traffic of private subnets across only the AVAILABLE NAT gateways.
   * The motivation is that NAT gateways aren't replicated across AZs
   * The awesomeness (hopefully) is that if an AZ goes down, you can re-apply this module so that all the private route tables
   *   get updated to using only the AVAILABLE NAT gateways.
   */
  nat_gateway_id = "${element(matchkeys(aws_nat_gateway.main.*.id, aws_nat_gateway.main.*.subnet_id, matchkeys(aws_subnet.public.*.id, aws_subnet.public.*.availability_zone, data.aws_availability_zones.available.names)), count.index)}"
}

resource "aws_route" "private_all_ipv6" {
  count = "${min(max(var.ngw_redundancy, 0), length(data.aws_availability_zones.all.names))}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id = "${element(aws_egress_only_internet_gateway.main.*.id, count.index)}"
}

/**
 * Reserved route table
 */

resource "aws_route_table" "spare" {
  vpc_id = "${aws_vpc.main.id}"
  tags {
    Name = "${var.name}-reserved"
  }
}

resource "aws_route_table_association" "spare" {
  count = "${length(aws_subnet.spare.*.id)}"
  subnet_id = "${aws_subnet.spare.*.id[count.index]}"
  route_table_id = "${aws_route_table.spare.id}"
}
