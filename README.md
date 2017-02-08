# basi/grafana

Grafana with some limited automated data sources creation.

## Description

It's ready for add some specific prometheus and elasticsearch data sources. If you think it has sense to generalize its implementation
and add more data sources just tell me.

At least if it does not work for you (most probably), you can take the idea. ;)

## Usage

To launch it as a docker container:

```
docker \
  run \
  -p 3000:3000 \
  -e "GF_SECURITY_ADMIN_PASSWORD=example" \
  -e "PROMETHEUS_ENDPOINT=http://prometheus:9090" \
  -e "ELASTICSEARCH_ENDPOINT=http://elasticsearch:9090" \
  -e "ELASTICSEARCH_USER=readuser" \
  -e "ELASTICSEARCH_PASSWORD=myelasticpass" \
  basi/grafana:latest
```

You can launch it as a swarm service:

```
docker\
  service create \
  --name grafana \
  --network monitoring \
  --publish 3000:3000 \
  -e "GF_SECURITY_ADMIN_PASSWORD=ADMIN_PASSWORD" \
  -e "PROMETHEUS_ENDPOINT=http://prometheus:9090" \
  -e "ELASTICSEARCH_ENDPOINT=http://elasticsearch:9090" \
  -e "ELASTICSEARCH_USER=readuser" \
  -e "ELASTICSEARCH_PASSWORD=myelasticpass" \
  basi/grafana:latest

```

Once you launch your service you'll need to import the desired dashboards, initially this has been prepared to import
this dashboard: [Docker Swarm & Container Overview](https://grafana.net/dashboards/609)
