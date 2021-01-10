#!/bin/bash

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
    docker logs -f "projects-$1"
else 
    printf "${RED}$1 container is not running or NOT EXISTS!!${NC}\n"
    exit
fi