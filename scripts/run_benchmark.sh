#!/bin/bash
function show_usage() {
    echo "Usage:"
    echo "   ./run_benchmark.sh <api_host_ip>" 
}

if [ $# -eq 0 ]; then
    echo "No arguments supplied. Exiting..."
    show_usage
    exit 1
elif [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    show_usage
else
    wrk -t ${nproc} -c 400 http://$1:8080
fi

