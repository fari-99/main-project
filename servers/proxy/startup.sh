#!/bin/bash -e

# Add php-fpm as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- nginx "$@"
fi

echo "[Start]"

FILES=/nginx_templates/*.conf

if [ ! -d /etc/nginx/sites-available/ ]; then
	mkdir -p /etc/nginx/sites-available/
fi

for file in $FILES
do
    filename="${file##*/}"

    if [ ! -f /etc/nginx/sites-available/$filename ]; then
    	case $filename in
            "sentry.conf")
                if [ $ENABLE_SENTRY == "false" ]; then
                    proceed="false"
                fi
                ;;
    		*)
				proceed="true"
    			;;
    	esac
		    	
    	if [ $proceed == "true" ]; then
	    	echo "Processing $file file..."
	    	j2 $file > /etc/nginx/sites-available/$filename
	    fi
    else
    	echo "$file exists or not required, skipping..."
    fi
done

echo "[Finish]"

exec "$@"