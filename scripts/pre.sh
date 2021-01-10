#!/bin/bash
source ./scripts/services.sh
source ./scripts/functions.sh

# Check is docker already installed
if docker &> /dev/null; then
    printf "${GREEN}[Checking Requirement]${NC} Docker is there :)"
    echo ""
else
    printf "${RED}[Checking Requirement]${NC} Docker is not there :\(\n"
    printf "${GREEN}Do you want us to install docker for you?${NC} (Y/n)\n"
    read inputDocker

    if [ $inputDocker == "Y" ]; then
        source ./scripts/docker/base.sh
        install_docker
        exit
    fi
fi

# Check if docker is active
check_docker_active