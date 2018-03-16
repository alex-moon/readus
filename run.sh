#!/bin/bash

# helper functions
function confirm() {
    while true; do
        read -p "[Y/n] " YESNO
        case "$YESNO" in
            [Yy]*|"" ) return 0;;
            [Nn]* ) return 1;;
            * ) printf "Try again hotshot. " ;;
        esac
    done
}

red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
reset="$(tput sgr0)"
function red() { echo "${red}${@}${reset}"; }
function green() { echo "${green}${@}${reset}"; }
function yellow() { echo "${yellow}${@}${reset}"; }

# vars
machine=readus

# let's do it!
if [[ -z "$(docker-machine ls -q | grep $machine)" ]]; then
    green "Creating docker machine"
    docker-machine create --driver virtualbox $machine
fi

if [[ "$(docker-machine status $machine)" != "Running" ]]; then
    green "Starting docker machine"
    docker-machine start $machine
fi

# green "Regenerating certs"
# yes | docker-machine regenerate-certs $machine

# green "Mounting NFS"
# if [[ "Linux" == "$(uname -s)" ]]; then
#     ./docker-machine-nfs-linux $machine
# else
#     docker-machine-nfs $machine
# fi

green "Loading env"
eval $(docker-machine env $machine)

green "Removing docker containers"
docker rm -f $(docker ps -a -q)

green "Starting docker containers"
docker-compose up -d

green "Done - your IP is:"
docker-machine ip $machine
