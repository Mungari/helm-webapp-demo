# Dockerfile

FROM python:3.9-buster

# install nginx
RUN apt-get update && apt-get install nginx vim -y --no-install-recommends
COPY nginx.default /etc/nginx/sites-available/default
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# copy source and install dependencies
RUN mkdir -p /opt/app
RUN mkdir -p /opt/app/pip_cache
RUN mkdir -p /opt/app/demo_app
COPY requirements.txt start-server.sh /opt/app/
COPY demo_app /opt/app/demo_app/
WORKDIR /opt/app
RUN pip install -r requirements.txt
RUN chown -R 1001:1001 /opt/app

ENV WEBAPP_PORT=8010

# start server
EXPOSE 8080
STOPSIGNAL SIGTERM
CMD ["/opt/app/start-server.sh"]