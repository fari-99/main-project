#!/bin/bash
# Function collections

# Color Var
RED='\033[0;31m'
GREEN='\033[0;32m'
BROWN='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'
SCRIPTPATH=$(pwd -P)

# Check is docker machine active
function check_docker_active() {
    docker_info=$(docker info 2>&1)

    if [[ $docker_info == *"connect to the Docker daemon"* ]]; then
        # if [ ! -f '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh' ]; then
            printf "${RED}"
            echo "Error found :"
            echo docker_info
            echo ""
            echo "Quit all tasks"
            printf "${NC}"
            exit
        # fi

        # Start docker script
        # printf "${PURPLE}Please run setup.sh again after this.${NC}\n" 1>&2
        # sh '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'
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