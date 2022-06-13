################################################################################
# AWS Specific
variable "aws_region" {
  type        = string
  description = "AWS Region in which to build image."
  default     = "us-east-1"
}

variable "aws_instance_type" {
  type        = string
  description = "Instance on which to build image."
  default     = "t2.micro"
}

variable "encrypt_boot" {
  type        = bool
  description = "Encrypt boot volume?"
  default     = false
}

variable "aws_kms_key_id" {
  type        = string
  description = "ARN for KMS Key ID to use for encrypting volume."
  default     = ""
}

################################################################################

variable "prefix" {
  type        = string
  description = "Prefix for naming image"
  default     = "cis-amazon-linux-2"
}

variable "owner" {
  type        = string
  description = "The person or group who launched these resources.  Must be a valid HashiCorp email prefix."
}

variable "ttl" {
  type        = string
  description = "Time in hours from the launch that a resource can be stopped/terminated. Use -1 for permanent resources."
  default     = "-1"
}

variable "config-as-code" {
  type        = string
  description = "Config-as-code tool used to provision this image."
  default     = "packer"
}

variable "repo" {
  type        = string
  description = "If a config-as-code value is set, the repository that holds the code used to create this resource."
  default     = ""
}
