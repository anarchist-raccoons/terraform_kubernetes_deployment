variable "host" { }
variable "username" { }
variable "password" { }
variable "client_certificate" { }
variable "client_key" { }
variable "cluster_ca_certificate" { }
variable "docker_image" { }
variable "app_name" { }
variable "port" { }

variable "primary_mount_size" {} 
variable "primary_mount_path" {}

variable "env_from" { }

variable "command" {
  default = []
}

variable "storage_account_params" {
  type = "map"
  description = "Parameters map for the Storage Class. The default works with azure_file. See https://kubernetes.io/docs/concepts/storage/storage-classes/"
  default = {
    skuname = "Standard_LRS"
  }
}

variable "storage_provisioner" {
  description = "Kubernetes Storage Provisioner. Ensure the storage_account_params are correct."
  default = "kubernetes.io/azure-file"
}

variable "second_mount_size" {
  default = "100M"
}
variable "second_mount_path" {
  default = "/data"
}

variable "image_pull_secrets" {
}

variable "resource_version" {
  description = "Unused variable, used to create a dependency sequence."
  type = "list"
  default = []
}