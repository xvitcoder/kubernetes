#!/bin/bash

# Create metallb namespace
echo "[TASK 1] Create metallb namespace"
kubectl create namespace metallb-system

# Create metallb config map
echo "[TASK 2] Create metallb configmap"
kubectl apply -f `dirname $0`/metallb-config-map.yaml

# Install metallb helm chart
echo "[TASK 3] Install metallb helm chart"
helm install metallb bitnami/metallb --set existingConfigMap=metallb-config --namespace metallb-system
