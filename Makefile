#!/usr/bin/make -f
include shared.env
-include .env

all: gen-env default-up up down debug shell setup site-serve site-build-dev \
	install-dependencies jekyll-build-dev jekyll-serve switch-channel \
	test-channel refresh-code-excerpts check-code check-links test debug-test \
	build-image build deploy deploy-preview-channel clean mostlyclean \
	maintainer-clean

.PHONY: all

.DEFAULT_GOAL := default-up


# Development Commands =========================================================


# Generate .env file with defaults.
# The .env file is used to store build arguments and environment variables.
# NOTE that using a `FIREBASE_TOKEN` is optional and not required.
# If you have generated a token via `firebase login:ci` and it is set in your 
# `.env` file, it will be used for deployment. Otherwise, the command will use 
# the manual setup described in `make deploy`.
# Usage: `make genenv`
.env:
	touch $@
genenv: .env
	@echo "# Auto-generated using \`make genenv\`" > $<
	tool/genenv-host-user.sh $(shell pwd)/$<
	@echo "FLUTTER_BRANCH=HEAD" >> $<
	@echo "FIREBASE_ALIAS=default" >> $<
	@echo "FIREBASE_TOKEN=" >> $<

	mkdir -p ./bundle ./.pub-cache

# Default goal in case if this file is executed as `./Makefile`.
default-up:
	make clean
	make genenv
	docker-compose build --no-cache site
	make up

# Run the dev conatiner and serve the Jekyll site.
up:
	docker-compose run --rm --service-ports site make jekyll-serve

# Bring down the running dev container.
down:
	docker-compose down

# Run the dev container and enter shell for debugging.
debug:
	docker-compose run --rm site bash

# Enter the shell of the *running* dev container.
shell:
	docker-compose exec site bash

# Build the dev container from scratch.
setup:
	make clean
	make genenv
	docker-compose build --no-cache site
	docker-compose run --rm site make site-build-dev

# Docker Compose site entry command.
# Can be used on both local and Docker development.
site-serve:
	make install-dependencies
	make jekyll-serve

# `make setup` entry command.
# Can be used on both local and Docker development.
site-build-dev:
	make install-dependencies
	make jekyll-build-dev

# Install required dependencies.
# Can be used on both local and Docker development.
install-dependencies:
	bundle install
	npm install
	dart pub get

# Build the Jekyll site with incremental.
# Can be used on both local and Docker development.
jekyll-build-dev:
	bundle exec jekyll build \
		--config _config.yml,_config_dev.yml \
		--incremental \
		--trace

# Serve the Jekyll site with livereload and incremental builds.
# Can be used on both local and Docker development.
jekyll-serve:
	bundle exec jekyll serve \
		--host ${SITE_HOST} \
		--port ${SITE_PORT} \
		--config _config.yml,_config_dev.yml \
		--livereload \
		--incremental \
		--trace

# Test hosting locally with FB emulator
emulate:
	firebase emulators:start --only hosting


# Testing locally from host ====================================================


# NOTE that these are for convenience of testing from outside of a container. 
# You could just as easily enter a fresh container shell and run these as any 
# code changes on host would be reflected inside the container. For example - 
# ```
# $ docker-compose run --rm site bash
# $ make switch-channel CHANNEL=dev
# $ tool/test.sh --target ${CHANNEL} --check-links --null-safety
# ```
CHANNEL ?= stable

# Convenience command to run inside of a container to switch the channel of the 
# flutter submodule. 
# NOTE that changes will be reflected in your local flutter repo.
# Usage: `make switch-channel CHANNEL=<channel>`
switch-channel:
	cd flutter && \
		git remote set-branches origin ${CHANNEL} && \
  		git fetch --depth=1 origin ${CHANNEL}:${CHANNEL} && \
  		git checkout ${CHANNEL} && \
		cd .. && \
		flutter doctor && \
		flutter --version

# Run tests against a channel.
# NOTE this will mirror test artifacts to local via the volume.
# Usage: `make test-channel CHANNEL=<channel>`
test-channel:
	docker-compose run --rm site tool/test.sh --target ${CHANNEL} \
		--check-links --null-safety

# Refresh code excerpts.
# NOTE this will mirror test artifacts to local via the volume.
# Usage: `make refresh-code-excerpts`
refresh-code-excerpts:
	docker-compose run --rm site tool/refresh-code-excerpts.sh --keep-dart-tool

# Test checking code snippets.
# NOTE this will mirror test artifacts to local via the volume.
# Usage: `make check-code`
check-code:
	docker-compose run --rm site tool/check-code.sh --refresh --null-safety

# Test checking links.
# NOTE this will mirror test artifacts to local via the volume.
# Usage: `make check-links`
check-links:
	docker-compose run --rm site tool/check-links.sh


# Build / Test / Deploy Commands ===============================================


FLUTTER_BRANCH ?= HEAD
TEST_TARGET_CHANNEL ?= stable
FIREBASE_ALIAS ?= default
IMAGE_NAME := flutter-site
COMMIT := $(shell git rev-parse --short HEAD)
CONTAINER_NAME := flutter-site-container

# Run all tests that would be run inside the container for the given target 
# channel on the GitHub Action `test` job.
# WARNING this can take long while to run!
# Usage: `make test TEST_TARGET_CHANNEL=<channel>`
test:
	docker build --rm --target test \
		--build-arg RUBY_VERSION=${RUBY_VERSION} \
		--build-arg NODE_VERSION=${NODE_VERSION} \
		--build-arg FLUTTER_BRANCH=${FLUTTER_BRANCH} \
		--build-arg TEST_TARGET_CHANNEL=${TEST_TARGET_CHANNEL} \
		-t ${IMAGE_NAME}:${COMMIT} .

# Allows for firing up a shell with a regular build and running shell scripts 
# manually to test the build. 
# Usage `make debug-test`
debug-test:
	docker build --rm --target dev \
		--build-arg RUBY_VERSION=${RUBY_VERSION} \
		--build-arg NODE_VERSION=${NODE_VERSION} \
		--build-arg FLUTTER_BRANCH=${FLUTTER_BRANCH} \
		-t ${IMAGE_NAME}:${COMMIT} .
	docker run --rm -it \
		-v ${PWD}/tool:/app/tool ${IMAGE_NAME}:${COMMIT} bash
	docker rmi -f ${IMAGE_NAME}:${COMMIT}

# Build the production image.
# Usage: `make build-image`
build-image:
	docker build --no-cache --rm --target builder \
		--build-arg RUBY_VERSION=${RUBY_VERSION} \
		--build-arg NODE_VERSION=${NODE_VERSION} \
		-t ${IMAGE_NAME}:${COMMIT} .

# Build the production image and copy site build to local. 
# This will reset and also clean up after finished. 
# Usage: `make build`
build:
	make clean
	make build-image
	docker run --rm -dt --name ${CONTAINER_NAME} ${IMAGE_NAME}:${COMMIT}
	docker cp ${CONTAINER_NAME}:/app/_site _site
	docker stop ${CONTAINER_NAME}
	docker rmi -f ${IMAGE_NAME}:${COMMIT}

# Deploy the Firebase hosting site from local.
# NOTE that if you have a FIREBASE_TOKEN exported or in your local `.env` file, 
# it will be used.
# This style is used inside the GitHub Action.
# Usage: `make deploy`
deploy:
ifndef FIREBASE_TOKEN
	firebase deploy -m ${COMMIT} --only hosting
else
	firebase use ${FIREBASE_ALIAS}
	firebase deploy -m ${COMMIT} \
		--only hosting \
		--non-interactive \
		--token ${FIREBASE_TOKEN} \
		--project ${FIREBASE_ALIAS} \
		--debug \
		--json
endif

# Get branch name. If on detached HEAD this command will return just HEAD.
PREVIEW_CHANNEL ?= $(shell git rev-parse --abbrev-ref HEAD)

# Deploy `_site` folder to a Firebase preview channel on your currently 
# selected project.
# Usage: `make deploy-preview-channel PREVIEW_CHANNEL=edit-readme`
deploy-preview-channel:
	firebase hosting:channel:deploy ${PREVIEW_CHANNEL}


# Utility Commands =============================================================


# Clean all caches, test, build files and all the dependencies.
# Stop and remove services' containers including volumes.
clean:
	rm -rf _site .jekyll* src/.jekyll* *.log tmp example.g .dart_tool .packages
	rm -rf bundle node_modules .pub-cache
	docker-compose down --volumes

# Purge all services' containers, images and volumes.
mostlyclean: clean
	docker-compose down --rmi all --volumes

# Also clean all the git ignored files.
# WARNING Make sure you run this command on committed changes!
maintainer-clean:
	docker-compose down --rmi all --volumes
	git clean -dfx && git submodule foreach --recursive git clean -dfx
	git submodule update --init --recursive
