#!/bin/bash

NFS_SERVER_IP="192.168.0.10"
NFS_SERVER_PATH="/srv/nfs/kubedata"

# Install nfs-client-provisioner helm chart
echo "[TASK 1] Install nfs-client-provisioner helm chart"
helm install nfs-client-provisioner stable/nfs-client-provisioner \
        --set nfs.server=$NFS_SERVER_IP \
        --set nfs.path=$NFS_SERVER_PATH \
        --set storageClass.defaultClass=true \
        --set storageClass.name="nfs" \
        --set nfs.mountOptions='[ "vers=4.1" "rsize=32768", "wsize=32768" ]' \
        --namespace kube-system
