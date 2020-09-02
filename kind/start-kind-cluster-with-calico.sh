#!/bin/bash

# Start kubernetes cluster
echo "[TASK 1] Start kubernetes cluster"
kind create cluster --name kubernetes --config cluster-with-calico.yaml

# Create calico network
echo "[TASK 2] Create calico network"
kubectl create -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml

# Setup metallb
echo "[TASK 3] Setup metallb"
sh ../yaml/metallb/setup-metallb.sh

# Setup nfs-client-provisioner
echo "[TASK 4] Setup nfs-client-provisioner"
sh ../yaml/nfs-client-provisioner/setup-nfs-client-provisioner.sh
