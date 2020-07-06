#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.42.42.100 kmaster.xvitcoder.com kmaster
172.42.42.101 kworker1.xvitcoder.com kworker1
172.42.42.102 kworker2.xvitcoder.com kworker2
172.42.42.10  knfs.xvitcoder.com knfs
EOF

# Install NFS utils
echo "[TASK 2] Install NFS server"
yum install -y -q nfs-utils > /dev/null 2>&1

# Enable NFS service
echo "[TASK 3] Enable and start NFS service"
systemctl enable nfs-server >/dev/null 2>&1
systemctl start nfs-server

# Update vagrant user's bashrc file
echo "/srv/nfs/kubedata *(rw,no_subtree_check,no_root_squash,no_all_squash,insecure,sync)" >> /etc/exports
exportfs -rav
