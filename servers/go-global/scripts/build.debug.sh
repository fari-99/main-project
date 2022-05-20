#!/bin/bash

set -e

# Run go mod init if go.mod doesn't exist
if [ ! -f "$GOPATH/src/$APP_NAME/go.mod" ]; then
	echo "[build.sh: Initialize go.mod for $APP_NAME]"
	go mod init $APP_NAME
fi

if [ ! -d "$GOPATH/src/$APP_NAME/vendor" ]; then
	echo "[build.sh: Go mod for $APP_NAME]"
	cd $GOPATH/src/$APP_NAME && go mod download
fi

# Copy .env file
if [ ! -f "$GOPATH/src/$APP_NAME/.env" ]; then
	echo "[build.sh: Copy .env for $APP_NAME]"
	cp $GOPATH/src/$APP_NAME/.env.example $GOPATH/src/$APP_NAME/.env
fi

if [ -f "/env_files/global.env" ] && [ -f "/env_files/app.env" ]
then
	echo "[EXPORT ENV GLOBAL TO CONTAINER]"
    export $(cat /env_files/global.env | sed 's/#.*//g' | xargs)
	export $(cat /env_files/app.env | sed 's/#.*//g' | xargs)
fi

#echo "[build.sh: Building binary for $APP_NAME]"
#cd $BUILDPATH && go build -o /servicebin
#echo "[build.sh: launching binary for $APP_NAME]"

# go to workdir
cd $GOPATH/src/$APP_NAME

# Run compiled service
echo "build project..."
go build -gcflags="all=-N -l" -o /server $GOPATH/src/$APP_NAME/cmd/servers/main/main.go

dlv --listen=:40000 --headless=true --api-version=2 --accept-multiclient exec /server