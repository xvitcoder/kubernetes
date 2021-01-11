#!/bin/bash

cecho(){
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    YELLOW="\033[1;33m"
    # ... ADD MORE COLORS
    NC="\033[0m" # No Color

    printf "${!1}${2} ${NC}\n"
}

# Setup metallb
cecho "GREEN" "[TASK 1] Setup metallb"
sh ../yaml/metallb/setup-metallb.sh

# Setup ingress controller
cecho "GREEN" "[TASK 2] Setup ingress controller"
sh ../yaml/ingress/install.sh

# Setup nfs-client-provisioner
cecho "GREEN" "[TASK 3] Setup nfs-client-provisioner"
sh ../yaml/nfs-client-provisioner/setup-nfs-client-provisioner.sh

# Unset host path storage class as default
cecho "GREEN" "[TASK 4] Unset host path storage class as default"
kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'

