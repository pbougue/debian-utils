#!/bin/bash

if [ $# -ne 1 ]; 
    then echo "Usage: $0 instance" >&2
    exit 1
fi

dropdb $1
createdb $1 -O navitia
psql $1 -c "create extension postgis;"
pushd ~/dev/sources/navitia/source/sql
PYTHONPATH=. alembic -x dbname="postgresql://navitia:navitia@localhost/$1" upgrade head
popd