#!/bin/bash

echo "Seeding the files..."

if [ ! -f /root/server.properties ]; then
    echo "Config file not found, copying the initial bunch of files..."
    cp -pri /PMNEWS/* /root/
else
    echo "Found existing config file!"
fi

echo "Running the main startup script..."

exec /start.sh -p /bin/php7/bin/php -f /root/PocketMine-MP.phar

