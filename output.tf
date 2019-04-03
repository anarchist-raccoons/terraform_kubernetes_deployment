output "second_volume_name" {
  value = "${kubernetes_persistent_volume_claim.second.spec.0.volume_name}"
}

output "service_resource_version" {
  value = "${kubernetes_service.default.metadata.0.resource_version}"
}

output "deployment_resource_version" {
  value = "${kubernetes_deployment.default.metadata.0.resource_version}"
}