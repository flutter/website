#!/bin/bash

TAG="${CIRRUS_TAG:-latest}"

# pull to make sure we are not rebuilding for nothing
docker pull "gcr.io/flutter-cirrus/build-website-image:$TAG"

docker build --tag "gcr.io/flutter-cirrus/build-website-image:$TAG" .
