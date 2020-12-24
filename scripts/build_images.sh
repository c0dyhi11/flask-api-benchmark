#!/bin/bash
cd ../docker-images/
for i in `find . -maxdepth 1 -mindepth 1 -type d -not -path '*/\.*'`; do
    cd $i
    docker build -t ${PWD##*/}:latest .
    cd ..
done
