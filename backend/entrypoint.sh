#!/bin/bash
# abort any errors (including if wait-for-it fails)
set -e
# wait for the database to be up
if [ -n "$MYSQL_HOST" ]; then
    echo "$MYSQL_HOST"
    /usr/bin/wait-for-it "$MYSQL_HOST:${MYSQL_PORT:-3306}"
fi
# run the main container command
echo "$@"
exec "$@"