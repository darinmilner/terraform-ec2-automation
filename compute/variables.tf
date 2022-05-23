variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = list(any)
}

variable "host_os" {
  type = string
}
