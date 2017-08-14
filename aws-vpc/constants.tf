/**
 * FOR IMPLEMENTATION USE ONLY
 * DO NOT OVERRIDE
 */

variable "az_order" {
  // Note that if AWS ever puts more than 8 AZs in a region,
  // we will only operate on the first 8
  default = [ "a", "b", "c", "d", "e", "f", "g", "h" ]
}
