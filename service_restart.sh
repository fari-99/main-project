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

printf "${GREEN}Restart container~~${NC}\n"
docker restart "projects-$1"

./logs.sh "$1"
