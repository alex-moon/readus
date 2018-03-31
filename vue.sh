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

function growler() {
    if [[ ! -z "`which notify-send`" ]]; then
        notify-send -i $1 -t 100 readus "$2"
    else
        red "Cannot create growler - try: sudo apt-get install notify-osd"
    fi
}
function growler-success() {
    growler emblem-default "$1"
}
function growler-error() {
    growler error "$1"
}

# let's do it
machine=readus
container=tornado
eval $(docker-machine env $machine)
container_id=$(docker ps | grep $container | head -n1 | awk '{ print $1 }')

if [[ -z "$container_id" ]]; then
    echo "Couldn't find container $container"
    exit 1
fi

while true; do
    inotifywait -e close_write,moved_to,create -r src/frontend/web/src |
    while read -r directory events filename; do

        green "Saw $events on $directory$filename"

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
            docker exec $container_id supervisorctl restart all

            growler-success "Vue.js build succeeded"
            green "Build succeeded"
        fi

    done
done
