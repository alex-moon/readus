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
yes | docker-machine regenerate-certs $machine

green "Mounting NFS"
if [[ "Linux" == "$(uname -s)" ]]; then
    ./docker-machine-nfs-linux $machine
else
    docker-machine-nfs $machine
fi

green "Loading env"
eval $(docker-machine env $machine)

green "Removing docker containers"
docker rm -f $(docker ps -a -q)

green "Starting docker containers"
docker-compose up -d

printf "Do you want to rebuild Spring? "
if confirm; then
    green "Running maven package"
    cd src/backend
    mvn package
    build_success=$?
    cd ../../

    if [[ $build_success != 0 ]]; then
        red "Build failed"
    else
        green "Restarting Spring"
        container_id=$(docker ps | grep spring | head -n1 | awk '{ print $1 }')
        docker exec $container_id supervisorctl restart all
        green "Build succeeded"
    fi
fi

printf "Do you want to rebuild Vue.js? "
if confirm; then
    green "Running npm build"

    cd src/frontend/web
    npm run build
    build_success=$?
    cd ../../../

    if [[ $build_success != 0 ]]; then
        growler-error "Vue.js build failed"
        red "Build failed"
    else
        green "Restarting tornado"
        container_id=$(docker ps | grep tornado | head -n1 | awk '{ print $1 }')
        docker exec $container_id supervisorctl restart all
        green "Build succeeded"
    fi
fi

green "Done - your IP is:"
docker-machine ip $machine
