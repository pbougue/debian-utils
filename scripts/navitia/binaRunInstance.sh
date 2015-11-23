#!/bin/bash

if [ $# -ne 1 ]; 
    then echo "Usage: $0 instance" >&2
    exit 1
fi

cd ~/dev/run/navitia/$1
~/dev/build/navitia/releaseClang/ed/ed2nav --connection-string="host=localhost user=navitia password=navitia dbname=$1"
~/dev/build/navitia/releaseClang/kraken/kraken
