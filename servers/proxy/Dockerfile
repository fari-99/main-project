FROM nginx:1.16.1-alpine	

# Install Python and Basic Python Tools
# Install Python and Basic Python Tools
RUN apk add --no-cache \
    bash \
    python \
    python-dev \
    yaml-dev \
    py-pip \
    shadow \
    && pip install j2cli

ADD ./templates/ /nginx_templates/
ADD ./startup.sh /usr/local/bin/startup.sh

ADD config/nginx.conf /etc/nginx/
ADD config/proxy_params /etc/nginx/

RUN rm /etc/nginx/conf.d/default.conf

RUN usermod -aG www-data nginx \
	&& adduser -S www-data -u 1000 \
	&& usermod -u 1000 www-data

ENTRYPOINT ["/usr/local/bin/startup.sh"]
CMD ["nginx"]

EXPOSE 80
