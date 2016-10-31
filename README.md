# basi/grafana

It allows to automatize the creation of data sources when launching the image.

It's ready for add some specific prometheus and elasticsearch data sources. If you think it has sense to generalize its implementation
and add more data sources just tell me.

For example:

```
docker\
  service create \
  --name grafana \
  --network monitoring \
  --publish 3000:3000 \
  -e "GF_SERVER_ROOT_URL=http://grafana.mydomain" \
  -e "GF_SECURITY_ADMIN_PASSWORD=ADMIN_PASSWORD" \
  -e "PROMETHEUS_ENDPOINT=http://prometheus:9090" \
  -e "ELASTICSEARCH_ENDPOINT=http://elasticsearch:9090" \
  -e "ELASTICSEARCH_USER=readuser" \
  -e "ELASTICSEARCH_PASSWORD=myelasticpass" \
  basi/grafana:latest

```

Once you launch your service you'll need to import the desired dashboards, initially this has been prepared to import
this dashboard: [Docker Swarm & Container Overview](https://grafana.net/dashboards/609)
