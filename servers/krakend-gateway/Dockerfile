FROM devopsfaith/krakend

USER root

RUN apt-get update && \
     apt-get install -y bash git openssh-server
# RUN apk update && apk upgrade && \
#    apk add --no-cache bash git openssh

RUN mkdir -p /etc/krakend

WORKDIR /etc/krakend/

ADD ./startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

ENV FC_ENABLE=1
ENV FC_SETTINGS="/etc/krakend/configs/settings"
ENV FC_PARTIALS="/etc/krakend/configs/partials"
ENV FC_TEMPLATES="/etc/krakend/configs/templates"
ENV FC_OUT="/etc/krakend/out.json"

ENTRYPOINT ["/usr/local/bin/startup.sh"]