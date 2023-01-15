#!/usr/bin/env bash
# start-server.sh
cd demo_app; gunicorn demo_app.wsgi --user www-data --bind 0.0.0.0:8010 --workers 3 &
nginx -g "daemon off;"