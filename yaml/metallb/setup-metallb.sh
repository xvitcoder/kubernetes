#!/bin/bash

# MetalLB version
VERSION='v0.9.3'

# Create metallb namespace
echo "[TASK 1] Create metallb namespace"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/$VERSION/manifests/namespace.yaml

echo "[TASK 2] Apply metallb deployment"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/$VERSION/manifests/metallb.yaml

echo "[TASK 3] Generate metallb secret key"
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

echo "[TASK 4] Apply metallb ConfigMap"
kubectl apply -f `dirname $0`/metallb-config-map.yaml
