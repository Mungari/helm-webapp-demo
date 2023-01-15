# Dockerfile

FROM python:3.9-buster

# install nginx
RUN apt-get update && apt-get install nginx vim gettext -y --no-install-recommends
COPY nginx.default.template /etc/nginx/conf.d/nginx.default.template
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
RUN chmod +x /opt/app/start-server.sh

ENV WEBAPP_PORT=8010
ENV NGINX_HTTP_PORT_NUMBER=8020

RUN  envsubst < /etc/nginx/conf.d/nginx.default.template > /etc/nginx/sites-available/default
# start server
EXPOSE 8020
STOPSIGNAL SIGTERM
ENTRYPOINT ["bash", "-c" , "/opt/app/start-server.sh"]