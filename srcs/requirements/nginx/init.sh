#!/bin/sh
set -e

# Substitute environment variables in the Nginx configuration template
envsubst '$DOMAIN_NAME' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

exec "$@"