provider "aws" {
  version = "~> 0.1"
}

data "aws_region" "current" {
  current = true
}

data "aws_availability_zones" "all" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_availability_zone" "all" {
  count = "${length(data.aws_availability_zones.all.names)}"
  name = "${data.aws_availability_zones.all.names[count.index]}"
}

data "aws_availability_zone" "available" {
  count = "${length(data.aws_availability_zones.available.names)}"
  name = "${data.aws_availability_zones.available.names[count.index]}"
}
