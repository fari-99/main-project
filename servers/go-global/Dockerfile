# Dockerfile References: https://docs.docker.com/engine/reference/builder/

FROM golang:1.15-alpine as base

ARG APP_NAME
ENV APP_NAME=$APP_NAME

RUN mkdir -p $GOPATH/src/$APP_NAME

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

# this is for install wkhtmltopdf, if you want to test it
# 1. delete container you want to test (ex : ./delete-container.sh mandala)
# 2. uncommenct this line (to end of wkhtmltopdf)
# 3. rebuild your container (ex : ./container-build.sh mandala) and wait until it's done
# 4. comment again this line (to end of wkhtmltopdf)
# RUN apk add --no-cache libxrender libxext gcompat su-exec wkhtmltopdf
# end of wkhtmltopdf

WORKDIR $GOPATH/src/$APP_NAME

# DEV 
FROM base as dev 
RUN apk add --no-cache \
    autoconf automake libtool gettext \
    gettext-dev make g++ texinfo curl

# fswatch is not available at alpine packages
# WORKDIR /root
# RUN wget https://github.com/emcrisostomo/fswatch/releases/download/1.14.0/fswatch-1.14.0.tar.gz
# RUN tar -xvzf fswatch-1.14.0.tar.gz
# WORKDIR /root/fswatch-1.14.0
# RUN ./configure
# RUN make 
# RUN make install 

# WORKDIR /home/app/src

RUN mkdir -p /go/_tools

ADD scripts/build.sh /go/_tools
ADD scripts/reflex.conf /go/_tools

RUN chmod +x /go/_tools/build.sh

# Add file watcher and swagger generator
RUN go get -u github.com/cespare/reflex

CMD ["reflex","-c","/go/_tools/reflex.conf"]