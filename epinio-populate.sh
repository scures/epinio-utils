#!/bin/bash
echo "What would you like?  all | app | service | config"
read varname
echo Generating $varname resources

function buildApplications {
  epinio push -n sample --container-image-url splatform/sample-app
  epinio push -n sample-2 --container-image-url splatform/sample-app
  exit 0
}

function buildServices {
  epinio service create mongodb-dev test-mongo-one
  epinio service create mongodb-dev test-mongo-two
  exit 0
}

function buildConfigurations() {
  epinio configuration create config-one foo bar
  epinio configuration create config-two foo bar
  exit 0
}


if [ "$varname" = "all" ]; then
  buildApplications
  buildServices
  buildConfigurations
fi

if [ "$varname" = "app" ] || [ "$varname" = "all" ]; then
  buildApplications
fi

if [ "$varname" = "service" ] || [ "$varname" = "all" ]; then
  buildServices
fi

if [ "$varname" = "config" ] || [ "$varname" = "all" ]; then
  buildConfigurations
fi
