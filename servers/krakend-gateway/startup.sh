#!/bin/bash -e

if [ -f $PWD/krakend.json ]; then
    cd $PWD && krakend run -c krakend.json -d
fi

exec "$@"
