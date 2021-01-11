#!/bin/bash

cecho(){
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    YELLOW="\033[1;33m"
    # ... ADD MORE COLORS
    NC="\033[0m" # No Color

    printf "${!1}${2} ${NC}\n"
}

# Start kubernetes cluster
cecho "GREEN" "[TASK 1] Start kubernetes cluster"
kind create cluster --name kubernetes --config cluster.yaml

# Create calico network
cecho "GREEN" "[TASK 2] Create calico network"
kubectl create -f https://docs.projectcalico.org/manifests/calico.yaml

cecho "GREEN" "==========================================="
cecho "GREEN" ".:: KUBERNETES CLUSTER IS BEING STARTED ::."
cecho "GREEN" "==========================================="

