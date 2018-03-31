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

# let's do it
green "Running npm build"
cd src/frontend/web
npm run build
cd ../../../

green "Restarting tornado"
machine=readus
eval $(docker-machine env $machine)
container=tornado
container_id=$(docker ps | grep $container | head -n1 | awk '{ print $1 }')

if [[ -z "$container_id" ]]; then
    echo "Couldn't find container $container"
    exit 1
fi

docker exec -it $container_id supervisorctl restart all

