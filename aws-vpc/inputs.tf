variable "name" {
  description = "VPC name. Will also be the prefix for the Name tag of all resources"
}

variable "cidr" {
  description = "VPC IPv4 CIDR block. Must be /16"
}

variable "ngw_redundancy" {
  description = "Number of NAT gateways. Maximum is the number of AZs in the region"
  default = 1
}

variable "ngw_primary" {
  description = "Active NAT gateway. Must be in [0, ngw_redundancy)"
  default = 0
}
