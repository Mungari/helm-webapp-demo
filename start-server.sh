#!/usr/bin/env bash
# start-server.sh
envsubst < /etc/nginx/conf.d/nginx.default.template > /etc/nginx/sites-available/default
cd demo_app; gunicorn demo_app.wsgi --user www-data --bind 0.0.0.0:8010 --workers 3 & nginx -g "daemon off;"