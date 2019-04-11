provider "kubernetes" {
  load_config_file = false
  host = "${var.host}"
  username = "${var.username}"
  password = "${var.password}"
  client_certificate = "${var.client_certificate}"
  client_key = "${var.client_key}"
  cluster_ca_certificate = "${var.cluster_ca_certificate}"
}

resource "kubernetes_deployment" "default" {
  
  metadata {
    name = "${var.app_name}"
    labels {
      app = "${var.app_name}"
    }
  }

  spec {
    selector {
      match_labels {
        app = "${var.app_name}"
      }
    }

    template {
      metadata {
        labels {
          app = "${var.app_name}"
        }
      }

      spec {
        image_pull_secrets { 
          name = "${var.image_pull_secrets}"
        }

        container {
          image = "${var.docker_image}"
          name = "${var.app_name}"

          env_from {
            secret_ref {
              name = "${var.env_from}"
            }
          }
          
          volume_mount {
            name = "${var.app_name}primary"
            mount_path = "${var.primary_mount_path}"
            }
          volume_mount {
            name = "${var.app_name}second"
            mount_path = "${var.second_mount_path}"
            }

            command = "${var.command}"
          }

        volume {
          name = "${var.app_name}primary"
          persistent_volume_claim {
          claim_name = "${kubernetes_persistent_volume_claim.primary.metadata.0.name}"
          }
        }
        volume {
            name = "${var.app_name}second"
            persistent_volume_claim {
            claim_name = "${kubernetes_persistent_volume_claim.second.metadata.0.name}"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "default" {
  metadata {
    name = "${var.app_name}"
    labels {
      app = "${var.app_name}"
    }
  }
  spec {
    selector {
      app = "${kubernetes_deployment.default.metadata.0.labels.app}"
    }
    session_affinity = "ClientIP"
    
    port {
      port = "${var.port}"
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_persistent_volume_claim" "primary" {
  metadata {
    name = "${var.app_name}primary"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests {
        storage = "${var.primary_mount_size}"
      }
    }
    storage_class_name = "${var.storage_class_name}"
  }
}

resource "kubernetes_persistent_volume_claim" "second" {
  metadata {
    name = "${var.app_name}second"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests {
        storage = "${var.second_mount_size}"
      }
    }
    storage_class_name = "${var.storage_class_name}"
  }
}