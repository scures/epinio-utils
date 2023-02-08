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
  exit 0
}

function buildServices {
  epinio service create mongodb-dev sample-mongo-$(generate_random_string)
  epinio service create mongodb-dev sample-mongo-$(generate_random_string)
  exit 0
}

function buildConfigurations() {
  epinio configuration create sample-config-$(generate_random_string) foo bar
  epinio configuration create sample-config-$(generate_random_string) foo bar
  exit 0
}

generate_random_string() {
  echo $(cat /dev/urandom | tr -dc 'a-z' | fold -w 8 | head -n 1)
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
