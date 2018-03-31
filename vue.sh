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
            red "Build failed"
            if [[ ! -z "`which notify-send`" ]]; then
                notify-send -i error -t 100 readus "Build failed"
            else
                red "Cannot create growler - try: sudo apt-get install notify-osd"
            fi
        else
            green "Restarting tornado"
            docker exec $container_id supervisorctl restart all

            if [[ ! -z "`which notify-send`" ]]; then
                notify-send -i emblem-default -t 100 readus "Build succeeded"
            else
                red "Cannot create growler - try: sudo apt-get install notify-osd"
            fi
        fi

    done
done
