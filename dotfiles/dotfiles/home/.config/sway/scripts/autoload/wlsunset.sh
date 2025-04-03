#!/usr/bin/env bash

coords=$(curl -s https://ipinfo.io/json/ | jq .loc | tr -d '"')

latitude=${coords%,*}
longitude=${coords#*,}

echo "Latitude: $latitude"
echo "Longitude: $longitude"

wlsunset -l $latitude -L $longitude

