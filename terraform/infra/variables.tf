# Main
variable "region" {
  type = string
}

variable "env" {
  type = string
}

variable "system" {
  default = "dev-system"
  type    = string
}

variable "accountNumber" {
  type = string
}

variable "dev_cidr" {
  type    = string
  }

variable "dev_key" {
  default = "dev-key"
}

variable "ami" {
  type    = string
}

variable "zone_name1" {
  type = string
}

variable "zone_name2" {
  type = string
}

variable "public_subnet1" {
  type = string
}

variable "public_subnet2" {
  type = string
}

variable "private_subnet1" {
  type = string
}

variable "kms_key_id" {
  type = string
}

variable "allowed_ports" {
  default = ["80", "443"]
}
# KMS
variable "kms_arn" {
  default = "arn:aws:kms:us-east-1:926788090244:key/1b30d22e-cff5-4079-81b3-89534779ee08"
  type    = string
}

