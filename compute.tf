resource "aws_instance" "dev-node" {
  instance_type          = var.instance-type
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.mtc-auth.id
  vpc_security_group_ids = [aws_security_group.mtc-sg.id]
  subnet_id              = aws_subnet.mtc-public-subnet.id
  user_data              = file("userdata.tpl")
  root_block_device {
    volume_size = 10 # 8 is default
  }

  # provisioner "local-exec" {
  #   command = templatefile("${var.host-os}-sshconfig.tpl", {
  #     hostname     = self.public_ip,
  #     user         = "ubuntu",
  #     identityfile = "./.ssh/mtckey"
  #   })
  #   interpreter = var.host-os == "windows" ? ["Powershell", "-Command"] : ["bash", "-c"]
  # }

  tags = {
    Name = "dev-node"
  }
}
