#!/bin/bash
echo "What would you like?  all | app | service | config"
read varname
echo Generating $varname resources

OS=`uname`
if [ "$OS" = 'Darwin' ]; then
    export LC_ALL=C
fi

function buildApplications {
  epinio push -n sample-$(generate_random_string) --container-image-url splatform/sample-app
  epinio push -n sample-$(generate_random_string) --container-image-url splatform/sample-app
}

function buildServices {
  epinio service create mongodb-dev sample-mongo-$(generate_random_string)
  epinio service create mongodb-dev sample-mongo-$(generate_random_string)
}

function buildConfigurations() {
  epinio configuration create sample-config-$(generate_random_string) foo bar
  epinio configuration create sample-config-$(generate_random_string) foo bar
}

generate_random_string() {
  echo $(cat /dev/urandom | tr -dc 'a-z' | fold -w 8 | head -n 1)
}


if [ "$varname" = "all" ]; then
  buildServices
  buildConfigurations
  buildApplications

  exit 0
fi

if [ "$varname" = "app" ]; then
  buildApplications
  exit 0
fi

if [ "$varname" = "service" ]; then
  buildServices
  exit 0
fi

if [ "$varname" = "config" ]; then
  buildConfigurations
  exit 0
fi
