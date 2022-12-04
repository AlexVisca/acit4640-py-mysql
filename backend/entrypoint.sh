#!/bin/bash
# abort any errors (including if wait-for-it fails)
set -e
# change backend config file
envsubst < /app/backend.conf.template > /app/src/backend.conf
# wait for the database to be up
if [ -n "$MYSQL_HOST" ]; then
    /usr/bin/wait-for-it "$MYSQL_HOST:${MYSQL_PORT:-3306}"
fi
# run the main container command
exec "$@"