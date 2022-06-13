packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  encrypted = var.encrypt_boot && var.aws_kms_key_id != "" ? "encrypted-" : ""
}

source "amazon-ebs" "cis-amazon-linux-2" {
  ami_name      = "${var.prefix}-${local.encrypted}{{timestamp}}"
  region        = var.aws_region
  instance_type = var.aws_instance_type
  encrypt_boot  = var.encrypt_boot
  kms_key_id    = var.encrypt_boot ? var.aws_kms_key_id : ""

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "CIS Amazon Linux 2 Benchmark v2* - Level 2*"
      root-device-type    = "ebs"
    }
    owners      = ["679593333241"]
    most_recent = true
  }
  communicator = "ssh"
  ssh_username = "ec2-user"

  tags = {
    Name           = "CIS Amazon Linux 2 Bechmark v2 - Level 2 - ${var.owner} {{timestamp}}"
    owner          = var.owner
    ttl            = var.ttl
    config-as-code = var.config-as-code
    repo           = var.repo
  }
}

build {
  hcp_packer_registry {
    bucket_name = "cis-amazon-linux-2"
    description = <<EOT
This image is based on CIS Amazon Linux 2 Benchmark - Level 2.
EOT
  }

  sources = [
    "source.amazon-ebs.cis-amazon-linux-2"
  ]

## via shell provisioner
#  provisioner "shell" {
#    execute_command = "{{.Vars}} bash '{{.Path}}'"
#    inline = [
#      "sudo yum update -y",
#      "sudo yum install -y yum-utils",
#      "sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo",
#      "sudo yum -y install terraform vault-enterprise consul-enterprise nomad-enterprise packer consul-template"
#    ]
#  }

  provisioner "ansible" {
    playbook_file = "./playbook.yaml"
  }
}
