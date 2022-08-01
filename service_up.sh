#!/bin/bash

source ./scripts/functions.sh

# Stop all task if docker daemon is not active

printf "${GREEN}"
echo "Descriptions:"
echo "this shell program are to up a container"
echo "flow of the program: stop (optional) -> build (optional) and up -> logs (optional)"
printf "\n"

echo "Options:"
echo "--build: build the program"
echo "--logs: logs after build"
echo "--stop: stop program"
printf "\n"

echo "Example:"
echo "./up-container.sh aghanim"
echo "./up-container.sh --build --logs aghanim"
printf "${NC}\n"

check_docker_active

for i in "$@"; do
  case $i in
    --build)
      BUILD="true"
      shift
      ;;
    --logs)
      LOGS="true"
      shift
      ;;
    --stop)
      STOP="true"
      shift
      ;;
    -*|--*)
      echo "Unknown option $i"
      exit 1
      ;;
    *)
      ;;
  esac
done

if [[ -n $1 ]]; then
    if [[ $STOP == "true" ]]; then
        printf "${GREEN}"
        echo "------ STOPPING CONTAINER -------"
        printf "${NC}"
        docker-compose stop "$1"
        printf "\n"
    fi

    if [[ $BUILD == "true" ]]; then
        printf "${GREEN}"
        echo "------ UP AND BUILD CONTAINER -------"
        printf "${NC}"
        docker-compose up -d --build "$1"
        printf "\n"
    else
        printf "${GREEN}"
        echo "------ UP CONTAINER -------"
        printf "${NC}"
        docker-compose up -d "$1"
        printf "\n"
    fi

    if [[ $LOGS == "true" ]]; then
        printf "${GREEN}"
        echo "------ CONTAINER LOGS -------"
        printf "${NC}"
        docker logs --tail 100 -f "projects-$1"
        printf "\n"
        exit
    fi
else 
    printf "${RED}"
    echo "Please provide the container name!!"
    printf "${NC}\n"
    exit;
fi