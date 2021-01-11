#!/bin/bash

# Install nfs-client-provisioner helm chart
helm install nfs-client-provisioner stable/nfs-client-provisioner --values values.yaml --namespace kube-system
