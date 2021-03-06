variable "name" {
  description = "VPC name. Will also be the prefix for the Name tag of most resources"
}

variable "cidr" {
  description = "VPC IPv4 CIDR block. Must be /16"
}

variable "ngw_redundancy" {
  description = "Number of NAT gateways. Maximum is the number of AZs in the region"
  default = 0
}
