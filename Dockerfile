FROM ruby:3.2.2-slim-bookworm@sha256:c672c463585283353df4bd5c712e80b7454dbb2c26808fafc8e10e2fdf17c301 AS base

ENV TZ=US/Pacific
RUN apt-get update && apt-get install -yq --no-install-recommends \
      apt-transport-https \
      build-essential \
      ca-certificates \
      curl \
      diffutils \
      git \
      gnupg \
      lsof \
      make \
      unzip \
      vim-nox \
      xdg-user-dirs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app



# ============== INSTALL FLUTTER ==============
FROM base AS flutter

COPY ./site-shared ./site-shared
COPY pubspec.yaml ./

ARG FLUTTER_BUILD_BRANCH=stable
ENV FLUTTER_BUILD_BRANCH=$FLUTTER_BUILD_BRANCH
ENV FLUTTER_ROOT=flutter
ENV FLUTTER_BIN=flutter/bin
ENV PATH="/flutter/bin:$PATH"

RUN git clone --branch $FLUTTER_BUILD_BRANCH --single-branch https://github.com/flutter/flutter /flutter/
VOLUME /flutter

# Set up Flutter
# NOTE You will get a warning "Woah! You appear to be trying to run flutter as root."
# and this is to be disregarded since this image is never deployed to production.
RUN flutter doctor
RUN flutter --version
RUN dart pub get



# ============== NODEJS INTSALL ==============
FROM flutter AS node

RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update -yq \
    && apt-get install nodejs -yq \
    && npm install -g npm # Ensure latest npm

# Install global Firebase CLI
RUN npm install -g firebase-tools@12.4.0



# ============== FLUTTER CODE TESTS ==============
FROM flutter AS tests

COPY ./ ./

# Only test the code here, checking links is purely for site deployment
ENTRYPOINT ["tool/test.sh"]


# ============== DEV / JEKYLL SETUP ==============
FROM node AS dev

ENV JEKYLL_ENV=development
RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle config set force_ruby_platform true
RUN bundle install

# Install Node deps
ENV NODE_ENV=development
COPY package.json package-lock.json ./
RUN npm install

COPY ./ ./

# Jekyl ports
EXPOSE 35730
EXPOSE 4002

# Firebase emulator port
# Airplay runs on :5000 by default now
EXPOSE 5502



# ============== BUILD PROD JEKYLL SITE ==============
FROM node AS build

ENV JEKYLL_ENV=production
RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle config set force_ruby_platform true
RUN BUNDLE_WITHOUT="test development" bundle install --jobs=4 --retry=2

ENV NODE_ENV=production
COPY package.json package-lock.json ./
RUN npm ci

COPY ./ ./

RUN echo 'User-agent: *\nDisallow:\n\nSitemap: https://docs.flutter.dev/sitemap.xml' > src/robots.txt

ARG BUILD_CONFIGS=_config.yml
ENV BUILD_CONFIGS=$BUILD_CONFIGS
RUN bundle exec jekyll build --config $BUILD_CONFIGS



# ============== TEST BUILT SITE LINKS ==============
FROM build as checklinks

CMD ["tool/check-links.sh"]
