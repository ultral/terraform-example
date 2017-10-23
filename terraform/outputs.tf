output "name" {
  value = "${kubernetes_service.echo.metadata.0.name}"
}
