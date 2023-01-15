# Demo app

Simple Hello, World app written in python using Django. Image is published on github registry using github actions.

Supports the following env variables for configuration:

| VAR | Required | Default            | Description|
|----------|----------|------------------------|---|
| NGINX_HTTP_PORT_NUMBER  | no      | 8020 | What port nginx will listen on |
| WEBAPP_PORT | no | 8010 | What port gunicorn will listen on |


To deploy on kubernetes:
1. Create a ``myvalues.yml`` file with the following:
    ```
    image:
        registry: ghcr.io
        repository: mungari/helm-webapp-demo
        tag: main
    containerPorts:
        http: 8020 # You can hange this, this will set NGINX_HTTP_PORT_NUMBER env var
    extraEnvVars: [WEBAPP_PORT=8010] # You can change the value 
    ```
3. Run the following commands:
   ```
   helm repo add my-repo https://charts.bitnami.com/bitnami

   helm install -f myvalues.yml my-release my-repo/nginx
   ```