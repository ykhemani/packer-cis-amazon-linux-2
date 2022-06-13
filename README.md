# packer-cis-amazon-linux-2

This repo contains a [HashiCor](https://hashicorp.com) [Packer](https://packer.io) configuration for creating an [AWS](https://aws.amazon.com/) [AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html) based on the [CIS Amazon Linux 2 Benchmark - Level 2](https://aws.amazon.com/marketplace/pp/prodview-wm36yptaecjnu) image.

The [Ansible Provisioner](https://www.packer.io/plugins/provisioners/ansible/ansible) is used to install HashiCorp software via a yum repo, including [Terraform](https://terraform.io), [Packer](https://packer.io), [Vault](https://vaultproject.io), [Consul](https://consul.io) and [Nomad](https://nomadproject.io).

---
