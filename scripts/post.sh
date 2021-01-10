#!/bin/bash
source ./scripts/services.sh
source ./scripts/functions.sh

# check if you want to install dnsmasq
printf "${GREEN}Do you want to install dnsmasq?${NC} (Y/n)"
read inputDnsmasq

if [ $inputDnsmasq == "Y" ]; then
    source ./scripts/dnsmasq/base.sh
    install_dnsmasq
fi