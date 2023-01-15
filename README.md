# Demo app

Simple Hello, World app written in python using Django. Image is published on github registry using github actions.

Supports the following env variables for configuration:

| VAR | Required | Default            | Description|
|----------|----------|------------------------|---|
| NGINX_HTTP_PORT_NUMBER  | no      | 8080 | What port nginx will listen on |
| WEBAPP_PORT | no | 8010 | What port gunicorn will listen on |


To deploy on kubernetes:
1. Create a ``myvalues.yml`` file with the following:
    ```
    image:
        registry: docker.io
        repository: birbatron/demo-app
        tag: main
    containerPorts:
        http: CUSTOM # You can hange this, this will set NGINX_HTTP_PORT_NUMBER env var
    extraEnvVars:
        - name: WEBAPP_PORT
          value: "8010" # You can change the value
    containerSecurityContext:
        enabled: true
        runAsUser: 1001
        runAsNonRoot: true
    ```
3. Run the following commands:
   ```
   helm repo add my-repo https://charts.bitnami.com/bitnami

   helm install -f myvalues.yml my-release my-repo/nginx
   ```