output "dev-ip" {
  value = aws_instance.dev-node.public_ip
}

output "connection-script" {
  value = templatefile("${var.host_os}-sshconfig.tpl", {
    hostname     = aws_instance.dev-node.public_ip,
    user         = "ubuntu",
    identityfile = "./.ssh/mtckey"
  })
}
