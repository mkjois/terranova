output "region" {
  value = "${data.aws_region.current.name}"
}

output "az_all" {
  value = "${data.aws_availability_zones.all.names}"
}

output "az_available" {
  value = "${data.aws_availability_zones.available.names}"
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
