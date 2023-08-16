ARG VERSION
FROM grafana/promtail:${VERSION:-2.8.4}

COPY promtail-config.yml /etc/promtail/config.yml

CMD ["-config.file=/etc/promtail/config.yml", "-config.expand-env=true"]
