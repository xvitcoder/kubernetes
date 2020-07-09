#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.42.42.100 k8s-master.xvitcoder.com k8s-master
172.42.42.101 k8s-worker1.xvitcoder.com k8s-worker1
172.42.42.102 k8s-worker2.xvitcoder.com k8s-worker2
172.42.42.10  k8s-nfs.xvitcoder.com k8s-nfs
EOF

# Install NFS utils
echo "[TASK 2] Install NFS server"
apt install -y nfs-utils > /dev/null 2>&1

echo "[TASK 4] Create export share"
mkdir -p /srv/nfs/kubedata
chown nobody:nogroup /srv/nfs/kubedata
chmod 777 /srv/nfs/kubedata
echo "/srv/nfs/kubedata *(rw,no_subtree_check,no_root_squash,no_all_squash,insecure,sync)" >> /etc/exports
exportfs -rav

# Enable NFS service
echo "[TASK 3] Enable and start NFS service"
systemctl enable nfs-server >/dev/null 2>&1
systemctl start nfs-server