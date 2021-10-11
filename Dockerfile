# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3

FROM ruby:${RUBY_VERSION}-buster AS base

ENV TZ=US/Pacific

ARG NODE_VERSION=15
ENV NODE_VERSION=$NODE_VERSION

RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -
RUN apt-get update && apt-get install -yq --no-install-recommends \
      sudo \
      build-essential \
      vim \
      git \
      diffutils \
      xdg-user-dirs \
      nodejs && \
      rm -rf /var/lib/apt/lists/*
RUN gem install bundler
RUN npm install -g npm firebase-tools superstatic

RUN touch /.dockerenv
ENV PATH="/app/flutter/bin:$PATH"

WORKDIR /app

# User base target =============================================================
FROM base AS user-base

ARG HOST_KERNEL_NAME
ARG HOST_GROUP_ID
ARG HOST_GROUP_NAME
ARG HOST_USER_ID
ARG HOST_USER_HOME
ARG HOST_USER_NAME

COPY ./tool/add-host-user.sh ./tool/add-host-user.sh
RUN tool/add-host-user.sh


# Dev target ===================================================================
FROM base AS dev

# Install Ruby deps
ENV JEKYLL_ENV=development
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Install Node deps
ENV NODE_ENV=development
COPY package.json package-lock.json ./
RUN npm install

COPY ./ ./

ARG FLUTTER_BRANCH
ENV FLUTTER_BRANCH=$FLUTTER_BRANCH

# Used if wanting to build the container with a different branch
# e.g. `make build FLUTTER_BRANCH=dev`
# This is not to be confused with the $TEST_TARGET_CHANNEL
RUN if test -n "$FLUTTER_BRANCH" -a "$FLUTTER_BRANCH" != "HEAD" ; then \
      cd flutter && \
      git remote set-branches origin "$FLUTTER_BRANCH" && \
      git fetch --depth=1 origin "$FLUTTER_BRANCH":"$FLUTTER_BRANCH" && \
      git checkout "$FLUTTER_BRANCH" ; \
    fi

# Set up Flutter
RUN flutter doctor
RUN flutter --version
RUN dart pub get

EXPOSE 35729
EXPOSE 4002


# Test target ==================================================================
# NOTE that instead of have a script that tests all targets,
# we could build a new docker container for each test and 
# start clean
FROM dev AS test

ARG TEST_TARGET_CHANNEL=stable
ENV TEST_TARGET_CHANNEL=$TEST_TARGET_CHANNEL
RUN tool/test.sh --target $TEST_TARGET_CHANNEL --check-links --null-safety


# Build target =================================================================
FROM base AS builder

COPY ./ ./

ENV JEKYLL_ENV=production
RUN bundle install

ENV NODE_ENV=production
RUN npm install

# NOTE this is a bit sneaky and we could be more clear about it 
# by having an actual production template for robots.txt rather 
# than changing the contents of the file at build/test time. 
# This is similarly seen in tool/check-links.sh
RUN echo "User-agent: *" > src/robots.txt && echo "Allow: /" >> src/robots.txt

RUN bundle exec jekyll build --config _config.yml


# Deploy target ================================================================
FROM builder AS deploy

ARG FIREBASE_TOKEN
ENV FIREBASE_TOKEN=$FIREBASE_TOKEN
ARG FIREBASE_ALIAS=default
ENV FIREBASE_ALIAS=$FIREBASE_ALIAS
ARG COMMIT=$(git rev-parse --short HEAD)
ENV COMMIT=$COMMIT

RUN firebase use $FIREBASE_ALIAS
RUN firebase deploy -m $COMMIT \
      --only hosting \
      --non-interactive \
      --token $FIREBASE_TOKEN \
      --project $FIREBASE_ALIAS \
      --debug \
	--json
