#!/bin/bash
source ././config.sh
source ./scripts/functions.sh

# NPM
for app in $NPM_APPS
do 
    echo "$app exist"
    # cd ../workspace/$app
    FILE=package.json
    if [ -f "./workspace/$app/$FILE" ]; then
        echo "$app : $FILE exist"
        cd ./workspace/$app
        npm install
    fi
    
done

