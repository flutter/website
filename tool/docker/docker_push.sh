#!/bin/bash

TAG="${CIRRUS_TAG:-latest}"

docker push "gcr.io/flutter-cirrus/build-website-image:$TAG"

