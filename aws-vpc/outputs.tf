output "region" {
  value = "${data.aws_region.current.name}"
}

output "azs" {
  value = "${data.aws_availability_zones.all.names}"
}
