FROM ruby:3.2.3-slim-bookworm@sha256:97fccffe954d1e0c7fa6634020379417d67435a7f9a7c10b6ef3f49e498307e6 as base

ENV TZ=US/Pacific
RUN apt-get update && apt-get install -yq --no-install-recommends \
      apt-transport-https \
      build-essential \
      ca-certificates \
      curl \
      git \
      gnupg \
      lsof \
      make \
      rsync \
      unzip \
      xdg-user-dirs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# ============== NODEJS INTSALL ==============
FROM base AS node

RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update -yq \
    && apt-get install nodejs -yq \
    && npm install -g npm # Ensure latest npm

# ============== BUILD PROD JEKYLL SITE ==============
FROM node AS build

ENV JEKYLL_ENV=production
ENV RUBY_YJIT_ENABLE=1
RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle config set force_ruby_platform true
RUN BUNDLE_WITHOUT="test development" bundle install --jobs=4 --retry=2

ENV NODE_ENV=production
RUN npm ci

COPY ./ ./

RUN echo 'User-agent: *\nDisallow:\n\nSitemap: https://docs.flutter.dev/sitemap.xml' > src/robots.txt

ARG BUILD_CONFIGS=_config.yml
ENV BUILD_CONFIGS=$BUILD_CONFIGS
RUN bundle exec jekyll build --config $BUILD_CONFIGS

