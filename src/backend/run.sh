#!/bin/bash

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

clear
if [[ "$1" == "build" ]]; then
    mvn package
else
    printf "Do you want to build first? "
    if confirm; then
        mvn package
    fi
fi
java -jar target/noise-neo4j-latest.jar

