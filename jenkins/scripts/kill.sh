#!/usr/bin/env bash

# Find the process ID (PID) of the running Java application
NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`

PID=$(pgrep -f "java -jar target/${NAME}-${VERSION}.jar")

if [ -z "$PID" ]; then
    echo "No running Java application found."
else
    echo "Stopping Java application with PID: $PID"
    kill $PID
fi
