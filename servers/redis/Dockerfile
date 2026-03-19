FROM redis:8.6-alpine

RUN apk add --no-cache \
	bash

VOLUME /redis/data

EXPOSE 6379

CMD ["redis-server"]