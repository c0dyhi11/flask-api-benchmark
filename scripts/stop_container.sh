#!/bin/bash
function show_usage() {
    echo "Usage:"
    echo "   ./stop_container.sh <image_name>" 
}

if [ $# -eq 0 ]; then
    echo "No arguments supplied. Exiting..."
    show_usage
    exit 1
elif [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    show_usage
else
    CONTAINER_ID=`docker ps | grep "$1" | awk '{print $1}'`
    if [[ ! -z "$CONTAINER_ID" ]]; then
        docker kill $CONTAINER_ID
    else
	echo "Container with image '$1' could not be found! exiting..."
	exit 1
    fi
fi

