#!/bin/bash
source ./scripts/services.sh
source ./scripts/collors.sh

function get_etc_host() {
    CONTAINER_LISTS="$CORE_CONTAINERS "
    CONTAINER_LISTS+="$SUPPORT_CONTAINERS "
    CONTAINER_LISTS+="$DESIGN_CONTAINERS "
    CONTAINER_LISTS+="$FAKER_CONTAINERS "

    printf "${RED}"
    echo "-------------------------------------"
    echo "Please paste this hosts configuration to etc/hosts"
    echo "NOTE : maybe some of the service don't have configuration proxy, but it's okay"
    echo "-------------------------------------"
    printf "${NC}"

    IFS=' ' read -ra ADDR <<< "$CONTAINER_LISTS"
    for i in "${ADDR[@]}"; do
        if [[ $i == *".fadhlan.loc"* ]]; then
            printf "127.0.0.1 $i\n"
        else 
            printf "127.0.0.1 $i.fadhlan.loc\n"
        fi
    done
}