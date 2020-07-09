#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.42.42.100 k8s-master.xvitcoder.com k8s-master
172.42.42.101 k8s-worker1.xvitcoder.com k8s-worker1
172.42.42.102 k8s-worker2.xvitcoder.com k8s-worker2
172.42.42.10  k8s-nfs.xvitcoder.com k8s-nfs
EOF

# Install docker from Docker-ce repository
echo "[TASK 2] Install docker container engine"
apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common > /dev/null 2>&1
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - > /dev/null 2>&1
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /dev/null 2>&1
apt update > /dev/null 2>&1
apt install -y docker-ce containerd.io > /dev/null 2>&1

echo "[TASK 3] Enable docker systemd cgroup"
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
mkdir -p /etc/systemd/system/docker.service.d
systemctl daemon-reload > /dev/null 2>&1


# Enable docker service
echo "[TASK 4] Enable and start docker service"
systemctl enable docker  > /dev/null 2>&1
systemctl start docker > /dev/null 2>&1


echo "[TASK 5] Configure containerd"
cat > /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

modprobe overlay > /dev/null 2>&1
modprobe br_netfilter > /dev/null 2>&1

cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system > /dev/null 2>&1

# Configure containerd
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml

# Restart containerd
systemctl restart containerd > /dev/null 2>&1

# Stop and disable firewalld
echo "[TASK 6] Stop and Disable firewalld"
ufw disable > /dev/null 2>&1

# Add sysctl settings
echo "[TASK 7] Add sysctl settings"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system >/dev/null 2>&1
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1

modprobe br_netfilter > /dev/null 2>&1

echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables
sudo sysctl -p

# Disable swap
echo "[TASK 8] Disable and turn off SWAP"
swapoff -a > /dev/null 2>&1
sed -i '/swap/d' /etc/fstab > /dev/null 2>&1

# Add yum repo file for Kubernetes
echo "[TASK 9] Add repo file for kubernetes"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - > /dev/null 2>&1
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
apt update > /dev/null 2>&1

apt install apt-transport-https curl > /dev/null 2>&1

# Install Kubernetes
echo "[TASK 10] Install Kubernetes (kubeadm, kubelet and kubectl)"
apt install -y kubeadm kubelet kubectl kubernetes-cni > /dev/null 2>&1

# Start and Enable kubelet service
echo "[TASK 11] Enable and start kubelet service"
systemctl enable kubelet > /dev/null 2>&1
systemctl start kubelet > /dev/null 2>&1

# Enable ssh password authentication
echo "[TASK 12] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl reload sshd > /dev/null 2>&1

# Set Root password
echo "[TASK 13] Set root password"
echo "root:kubeadmin" | sudo chpasswd > /dev/null 2>&1

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc
