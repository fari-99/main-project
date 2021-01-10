#!/bin/bash
source ./scripts/collors.sh
source ./scripts/functions.sh

if [ -z $1 ]; then
	printf "${RED}"
	echo "Please provide the container name!!"
	printf "${NC}\n"
	exit;
fi

# Stop all task if docker daemon is not active
check_docker_active

CHECK=$(check_container_running "$1")

if [ $? == 1 ]; then
    printf "${GREEN}$1 container is running, connecting to container~~${NC}\n"
    docker exec -it "projects-$1" bash
else 
    printf "${RED}$1 container is not running or NOT EXISTS!!${NC}\n"
    exit
fi