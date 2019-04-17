variable "host" { }
variable "username" { }
variable "password" { }
variable "client_certificate" { }
variable "client_key" { }
variable "cluster_ca_certificate" { }
variable "docker_image" { }
variable "app_name" { }
variable "port" { }

variable "env_from" { }

variable "command" {
  default = []
}

variable "primary_mount_path" {
}
variable "secondary_mount_path" {
}

variable "secondary_sub_path" {
  default = ""
}

variable "image_pull_secrets" {
}

variable "resource_version" {
  description = "Unused variable, used to create a dependency sequence."
  type = "list"
  default = []
}

variable "pvc_claim_name" {}

variable "replicas" {
  default = 1
}