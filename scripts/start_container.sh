#!/bin/bash
function show_usage() {
    echo "Usage:"
    echo "   ./start_container.sh <image_name>" 
}

if [ $# -eq 0 ]; then
    echo "No arguments supplied. Exiting..."
    show_usage
    exit 1
elif [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    show_usage
else
    docker run -d -p 8080:8080 $1
fi

