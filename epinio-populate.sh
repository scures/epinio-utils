#!/bin/bash
echo -n "💠 What would you like?  all | app | service | config | ns => "
read type
echo Generating $type resources

OS=`uname`
if [ "$OS" = 'Darwin' ]; then
    export LC_ALL=C
fi

function buildApplications {
  epinio push -n sample-app-$(generate_random_string) --container-image-url splatform/sample-app
  epinio push -n sample-app-$(generate_random_string) --container-image-url splatform/sample-app
}

function buildServices {
  epinio service create mongodb-dev sample-mongo-$(generate_random_string)
  epinio service create mongodb-dev sample-mongo-$(generate_random_string)
}

function buildConfigurations() {
  epinio configuration create sample-config-$(generate_random_string) foo bar
  epinio configuration create sample-config-$(generate_random_string) foo bar
}

function buildNamespaces() {
  epinio namespace create sample-ns-$(generate_random_string)
  epinio namespace create sample-ns-$(generate_random_string)
}

generate_random_string() {
  echo $(cat /dev/urandom | tr -dc 'a-z' | fold -w 8 | head -n 1)
}


if [ "$type" = "all" ]; then
  buildServices
  buildConfigurations
  buildApplications
  buildNamespaces

  exit 0
fi

if [ "$type" = "app" ]; then
  buildApplications
  exit 0
fi

if [ "$type" = "service" ]; then
  buildServices
  exit 0
fi

if [ "$type" = "config" ]; then
  buildConfigurations
  exit 0
fi

if [ "$type" = "ns" ]; then
  buildNamespaces
  exit 0
fi
