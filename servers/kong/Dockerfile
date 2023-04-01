FROM golang:1.19-alpine as builder

WORKDIR /app

# Copy the plugin code into the container
COPY . .

RUN apk update && apk upgrade

# import all plugins to container on path /kong/plugins
RUN mkdir -p /kong/plugins
COPY /plugins /kong/plugins

# Build Golang Custom Plugins
RUN cd /kong/plugins/template_go_plugins && go mod download && go build -o test_go_plugin main.go

FROM kong:3.2.2

USER root

# Move binary code to your desired path
COPY --from=builder /kong/plugins/template_go_plugins/test_go_plugin /usr/local/bin/test_go_plugin