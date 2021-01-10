#!/bin/bash
source ./scripts/collors.sh

# Function collections

SCRIPTPATH=$(pwd -P)

# Check is docker machine active
function check_docker_active() {
    docker_info=$(docker info 2>&1)

    if [[ $docker_info == *"connect to the Docker daemon"* ]]; then
        printf "${RED}"
        echo "Error found :"
        echo docker_info
        echo ""
        echo "Quit all tasks"
        printf "${NC}"
        exit
    fi

    printf "${BROWN}[Check Requirement] Docker is installed${NC} $*\n"
}

# Check is container exist or running
function check_container_running() {
    CONTAINER=$1

    RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)

    if [ "$RUNNING" == "true" ]; then
        return 1
    else
        return 0
    fi
}