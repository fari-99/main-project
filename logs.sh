#!/bin/bash
source ./scripts/functions.sh
source ./scripts/collors.sh

if [ -z $1 ]; then
	printf "${RED}"
	echo "Please provide the container name!!"
	printf "${NC}\n"
	exit;
fi

# Stop all task if docker daemon is not active
check_docker_active

docker logs -f "projects-$1"