variable "host-os" {
  type    = string
  default = "windows"
}

variable "instance-type" {
  type    = string
  default = "t2.micro" # free tier
}

variable "vpc-cidr" {
  type    = string
  default = "10.120.0.0/16"
}

variable "subnet-cidr" {
  type    = string
  default = "10.120.1.0/24"
}
