FROM grafana/grafana:3.1.1

RUN apt-get update && apt-get install -y curl

ADD ./rootfs /

ENTRYPOINT ["/init.sh"]
