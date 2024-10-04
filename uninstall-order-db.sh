#!/bin/bash
echo "Removing the PODS & NAMESPACES for the config-db Components"
echo "*******************************"
NAMESPACE="order-db"
RELEASE_NAME="order-db"

helm delete $RELEASE_NAME -n $NAMESPACE

kubectl delete namespace $NAMESPACE
echo "*******************************"
echo "config-db uninstalled successfully"
echo "*******************************"
