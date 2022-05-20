#!/bin/bash

source ./scripts/services.sh
source ./scripts/functions.sh

# create folder workspace
if [ ! -d workspace ]; then
echo "workspace folder not exists, create new one"
mkdir workspace
chmod +xwr workspace
fi

# create logs folder
if [ ! -d logs ]; then
echo "logs folder not exists, create new one"
mkdir logs
chmod +xwr logs
fi

printf "${RED}"
echo "-------------------------------------"
echo "----- Docker Build MAIN Project -----"
echo "-------------------------------------"
printf "${NC}\n"

source ./scripts/pre.sh

docker-compose up -d --build $CONTAINER_LISTS

source ./scripts/post.sh

printf "${GREEN}"
echo "---------------------------------------------------"
echo "------- Build Completed. Now Create Somthing ------"
echo "---------------------------------------------------"
printf "${NC}\n"