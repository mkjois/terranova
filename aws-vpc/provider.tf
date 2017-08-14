provider "aws" {
  version = "~> 0.1"
}

data "aws_region" "current" {
  current = true
}

data "aws_availability_zones" "all" {}
