output "name" {
  value = "${kubernetes_replication_controller.echo.metadata.0.name}"
}
