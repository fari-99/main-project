#!/bin/bash -e

source services.sh

# Add php-fpm as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- nginx "$@"
fi

echo "[Start]"

FILES=/nginx_templates/*.conf

if [ ! -d /etc/nginx/sites-available/ ]; then
	mkdir -p /etc/nginx/sites-available/
else
	# Empty all the available sites every time restart to make sure
	# keep updated with SVC_LISTS value
	rm /etc/nginx/sites-available/*.conf
fi

# Get apps from environment
CONTAINER_LISTS+=""
while IFS=' ' read -ra APPS; do
	for i in "${APPS[@]}"; do
		if [ -f /nginx_templates/$i.conf ]; then
			echo "Processing $i service..."
			j2 /nginx_templates/$i.conf > /etc/nginx/sites-available/$i.conf
		else
			echo "$i template is not found, skip..."
		fi
	done
done <<< "$CONTAINER_LISTS"

echo "[Finish]"

exec "$@"
