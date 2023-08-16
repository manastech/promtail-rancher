# promtail-rancher

This is a customized Docker image of `grafana/promtail` with configuration to scrape logs from Docker and apply labels from Rancher 1.6 labels.

When deploying this image, it needs privileged access to the host and the Docker socket `/var/run/docker.sock` mounted and accessible in the image.

Environment configuration:

- `LOKI_URL` the URL for the Loki server (default: http://loki:3100/loki/api/v1/push)
- `TENANT_ID` the Loki tenant ID (default: `manas`)
- `ENVIRONMENT` the value for a static label `env` applied to all pushed logs

The pushed logs have extra labels:

- `container` computed from the Docker container name
- `stack_service` computed from the container label `io.rancher.stack_service.name`

Also, logs for Rancher system containers (ie. those with a label `io.rancher.container.system=true`) are not pushed.
