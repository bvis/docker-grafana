#!/bin/bash
set -o monitor

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [ ! -z ${GOOGLE_AUTH_CLIENT_ID+x} ]; then
    sed -i "/^\[auth.google\]$/,/^\[/ s/^;enabled = false/enabled = true/" /etc/grafana/grafana.ini
    sed -i "/^\[auth.google\]$/,/^\[/ s/^;allow_sign_up = true/allow_sign_up = false/" /etc/grafana/grafana.ini
    sed -i "/^\[auth.google\]$/,/^\[/ s/^;client_id = some_client_id/client_id = ${GOOGLE_AUTH_CLIENT_ID}/" /etc/grafana/grafana.ini
    sed -i "/^\[auth.google\]$/,/^\[/ s/^;client_secret = some_client_secret/client_secret = ${GOOGLE_AUTH_CLIENT_SECRET}/" /etc/grafana/grafana.ini
    printf "${GREEN}Google-Auth login activated!${NC}\n"
fi

exec /run.sh "$@" &

for i in {90..0}; do
  if curl -sf "http://localhost:3000"; then
    break
  fi
  printf "."
  sleep 1
done

if [ "$i" = 0 ]; then
  printf "\n${RED}Grafana start timeout!${NC}\n"
  exit 1
fi
printf "${GREEN}Grafana service ready!${NC}\n"

echo
    for f in /initgrafana.d/*; do
        case "$f" in
            *.sh)     echo "$0: running $f"; . "$f" ;;
            *)        echo "$0: ignoring $f" ;;
        esac
        echo
    done

jobs

fg %1
