provider "kubernetes" {
  config_context = "minikube"
}

resource "kubernetes_pod" "echo" {
  metadata {
    name = "echo-example"

    labels {
      App = "echo"
    }
  }

  spec {
    container {
      image = "hashicorp/http-echo:0.2.1"
      name  = "example2"
      args = ["-listen=:88", "-text='${var.text}'"]

      port {
        container_port = 88
      }
    }
  }
}

resource "kubernetes_service" "echo" {
  metadata {
    name = "echo-example"
  }

  spec {
    selector {
      App = "${kubernetes_pod.echo.metadata.0.labels.App}"
    }

    port {
      port        = 80
      target_port = 88
    }

    type = "NodePort"
  }
}

