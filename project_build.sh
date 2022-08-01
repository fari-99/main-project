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

CONTAINER_LISTS="$CORE_CONTAINERS "
CONTAINER_LISTS+="$SUPPORT_CONTAINERS "
CONTAINER_LISTS+="$DESIGN_CONTAINERS "
CONTAINER_LISTS+="$FAKER_CONTAINERS "
CONTAINER_LISTS+="$DATABASE_CONTAINERS "
CONTAINER_LISTS+="$TEST_CONTAINERS "
CONTAINER_LISTS+="$WEB_CONTAINERS "
CONTAINER_LISTS+="$API_GATEWAY "

docker-compose up -d --build $CONTAINER_LISTS

source ./scripts/post.sh

printf "${GREEN}"
echo "---------------------------------------------------"
echo "------- Build Completed. Now Create Somthing ------"
echo "---------------------------------------------------"
printf "${NC}\n"