provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# Create Namespace
resource "kubernetes_namespace" "order_db" {
  metadata {
    name = "order-db"
  }
}

# Create Helm Release for PostgreSQL
resource "helm_release" "postgresql" {
  name       = "order-db"
  namespace  = kubernetes_namespace.order_db.metadata[0].name
  chart      = "oci://registry-1.docker.io/bitnamicharts/postgresql"

  set {
    name  = "postgresql.postgresqlPasswordSecret"
    value = "postgres-credentials"
  }

}
