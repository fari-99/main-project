#!/bin/bash
source ./scripts/collors.sh
source ./scripts/functions.sh

if [ -z $1 ]; then
	printf "${RED}"
	echo "Please provide the service name!!"
	printf "${NC}\n"
	exit;
fi

# Stop all task if docker daemon is not active
check_docker_active

printf "${GREEN}Deleting service $1${NC}\n"
docker rm -f "projects-$1"
