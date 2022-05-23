resource "aws_key_pair" "mtc-auth" {
  key_name   = "mtckey"
  public_key = file("/mnt/workspace/mtckey.pub")
}

resource "aws_instance" "dev-node" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.mtc-auth.id
  vpc_security_group_ids = var.security_group_id
  subnet_id              = var.subnet_id
  user_data              = file("${path.module}/userdata.tpl")
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
