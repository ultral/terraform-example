output "name" {
  value = "${kubernetes_replication_controller.echo.metadata.0.name}"
}

output "lb_ingress" {
  value = "${kubernetes_service.echo.load_balancer_ingress.0.ip}"
}
