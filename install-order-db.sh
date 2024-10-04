#!/bin/bash
echo "Creating the Namespaces for the order-db Components"
echo "*******************************"

NAMESPACE="order-db"
RELEASE_NAME="order-db"
if kubectl get namespace "$NAMESPACE" >/dev/null 2>&1; then
  echo "Namespace $NAMESPACE already exists."
else
  echo "Creating namespace $NAMESPACE..."
  kubectl create namespace "$NAMESPACE"

fi

helm install $RELEASE_NAME oci://registry-1.docker.io/bitnamicharts/postgresql --namespace $NAMESPACE \
--set postgresql.postgresqlPasswordSecret=postgres-credentials

export POSTGRES_PASSWORD=$(kubectl get secret --namespace order-db order-db-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
echo "*******************************"
echo "ATTENTION !! - The PostgreSQL PASSWORD is: $POSTGRES_PASSWORD"
echo "*******************************"
echo "Please use this password to login to database"
