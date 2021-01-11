#!/bin/bash

cecho(){
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    YELLOW="\033[1;33m"
    # ... ADD MORE COLORS
    NC="\033[0m" # No Color

    printf "${!1}${2} ${NC}\n"
}

# Setup monitoring
cecho "GREEN" "[TASK 1] Setup monitoring prometheus and grafana"
sh ../yaml/monitoring/install.sh

sleep 5

# Setup logging
cecho "GREEN" "[TASK 2] Setup logging EFK stack"
sh ../yaml/efk/install.sh
