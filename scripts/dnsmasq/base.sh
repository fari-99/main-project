#!/bin/bash
source ./scripts/collors.sh

function install_dnsmasq() {
    if [[ $EUID > 0 ]]; then 
        printf "${RED}[CHECK REQUIREMENT]${NC} Please run this on root\n"
        exit
    fi

    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)
            install_dnsmasq_linux
            ;;
        Darwin*)    
            install_dnsmasq_mac
            ;;
        CYGWIN*)    machine=Cygwin;;
        MINGW*)     machine=MinGw;;
        *)          machine="UNKNOWN:${unameOut}"
    esac
}

function install_dnsmasq_linux() {
    if ! command -v dnsmasq &> /dev/null; then
        printf "${RED} dnsmasq not installed, proceed to install dnsmasq${NC}\n" 
        printf "${GREEN} Running apt-get update${NC}\n"
        sudo apt-get update

        printf "${GREEN}INSTALLING dnsmasq${NC}\n"
        sudo apt-get install dnsmasq
    fi

    if [ -f /etc/dnsmasq.conf ]; then
        printf "${BLUE}BACKUP dnsmasq.conf default${NC}\n"
        mv /etc/dnsmasq.conf /etc/dnsmasq_backup.conf
    fi

    printf "${RED}CHANGE dnsmasq.conf default with our project dnsmasq.conf${NC}\n"
    \cp ./scripts/dnsmasq/dnsmasq.conf /etc/dnsmasq.conf

    printf "${GREEN}Restart dnsmasq to setup our configuration${NC}\n"
    sudo systemctl restart dnsmasq
}

function install_dnsmasq_mac() {
    if ! command -v brew &> /dev/null; then
        printf "${RED}Brew is not installed, ${GREEN}proceed to install brew${NC}\n"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    if ! command -v dnsmasq &> /dev/null; then
        printf "${RED} dnsmasq not installed, ${GREEN} proceed to install dnsmasq${NC}\n"
        printf "${GREEN} Running brew update${NC}\n"
        brew update

        printf "${GREEN}INSTALLING dnsmasq${NC}\n"
        brew install dnsmasq
    fi

    if [ -f /etc/dnsmasq.conf ]; then
        printf "${BLUE}BACKUP dnsmasq.conf default${NC}\n"
        mv /etc/dnsmasq.conf /etc/dnsmasq_backup.conf
    fi

    printf "${RED}CHANGE dnsmasq.conf default with our project dnsmasq.conf${NC}\n"
    \cp ./scripts/dnsmasq/dnsmasq.conf /etc/dnsmasq.conf

    printf "${GREEN}Restart dnsmasq to setup our configuration${NC}\n"
    sudo launchctl stop homebrew.mxcl.dnsmasq
    sudo launchctl start homebrew.mxcl.dnsmasq
}