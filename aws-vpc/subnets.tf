/**
 * WHAT'S HAPPENING HERE?
 *
 * Our VPC has a /16 IPv4 CIDR block.
 * We assume that this could be split into up to 8 availability zones, each with a /19 block.
 * We partition the /19 block into two /20 blocks.
 * The first /20 block is our private subnet for that AZ (4096 addresses).
 * The other /20 block is split into two /21 blocks.
 * The first /21 block is our public subnet for that AZ (2048 addresses).
 * The other /21 block is a reserved subnet for that AZ for potential future needs.
 * Applications should NEVER rely on living in the reserved subnet.
 * Repeat for up to 8 AZs.
 *
 * Similar logic applies to our VPC's /56 IPv6 CIDR block.
 * Except that currently, subnet IPv6 blocks must be /64 blocks.
 * So each of our private, public, and reserved subnets gets nice and fat /64 block.
 *
 * Inspired by:
 * https://medium.com/aws-activate-startup-blog/practical-vpc-design-8412e1a18dcc
 */

resource "aws_subnet" "private" {
  count = "${length(data.aws_availability_zones.all.names)}"
  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "${element(sort(data.aws_availability_zones.all.names), count.index)}"
  cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block, 4, 2 * count.index)}"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 32 * count.index)}"
  tags {
    Name = "${var.name}-private-${element(data.aws_availability_zone.all.*.name_suffix, count.index)}"
  }
}

resource "aws_subnet" "public" {
  count = "${length(data.aws_availability_zones.all.names)}"
  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "${element(sort(data.aws_availability_zones.all.names), count.index)}"
  cidr_block = "${cidrsubnet(cidrsubnet(aws_vpc.main.cidr_block, 4, 2 * count.index + 1), 1, 0)}"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 32 * count.index + 1)}"
  tags {
    Name = "${var.name}-private-${element(data.aws_availability_zone.all.*.name_suffix, count.index)}"
  }
}

resource "aws_subnet" "spare" {
  count = "${length(data.aws_availability_zones.all.names)}"
  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "${element(sort(data.aws_availability_zones.all.names), count.index)}"
  cidr_block = "${cidrsubnet(cidrsubnet(aws_vpc.main.cidr_block, 4, 2 * count.index + 1), 1, 1)}"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 32 * count.index + 2)}"
  tags {
    Name = "${var.name}-private-${element(data.aws_availability_zone.all.*.name_suffix, count.index)}"
  }
}
