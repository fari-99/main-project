#!/bin/bash
source ./scripts/collors.sh

function install_docker() {
    if [[ $EUID > 0 ]]; then 
        printf "${RED}[CHECK REQUIREMENT]${NC} Please run this on root\n"
        exit
    fi

    printf "${GREEN}Get docker${NC}\n"
    curl -fsSL https://get.docker.com -o ./scripts/docker/get-docker.sh
    
    printf "${GREEN}Install docker${NC}\n"
    sudo sh ./scripts/docker/get-docker.sh

    printf "${GREEN}Made docker run as a non-root user${NC}\n"
    sudo usermod -aG docker $SUDO_USER

    printf "${GREEN}Please restart the script to take effect${NC}\n"
    exit
}