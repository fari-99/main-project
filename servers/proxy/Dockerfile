FROM nginx:1.15

# Install Python and Basic Python Tools
RUN apt-get update \
    && apt-get install -y python python-dev libyaml-dev python-pip \
    && pip install j2cli

ADD ./templates/ /nginx_templates/
ADD ./startup.sh /usr/local/bin/startup.sh

ADD config/nginx.conf /etc/nginx/
ADD config/proxy_params /etc/nginx/

RUN rm /etc/nginx/conf.d/default.conf
# RUN echo "upstream php-upstream { server php-fpm:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

ENTRYPOINT ["/usr/local/bin/startup.sh"]
CMD ["nginx"]

EXPOSE 80
