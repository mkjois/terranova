resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
  tags {
    Name = "${var.name}"
  }
}

resource "aws_egress_only_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_nat_gateway" "main" {
  count = "${min(max(var.ngw_redundancy, 0), length(data.aws_availability_zones.all.names))}"
  allocation_id = "${element(aws_eip.ngw.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  depends_on = [ "aws_internet_gateway.main" ]
}

resource "aws_eip" "ngw" {
  count = "${min(max(var.ngw_redundancy, 0), length(data.aws_availability_zones.all.names))}"
  vpc = true
  depends_on = [ "aws_internet_gateway.main" ]
}
