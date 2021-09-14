#!/usr/bin/make -f
include shared.env
-include .env


all: gen-env up down debug shell setup serve switch-channel test-channel \
	refresh-code-excerpts check-code check-links test debug-test build \
	build-image deploy stage clean reinstall purge

.DEFAULT_GOAL := up
.PHONY: all


# =================== Development Commands ==================

.env:
	touch $@

# Generate .env file with defaults
# The .env file is used to store local secrets and settings
# NOTE that using a `FIREBASE_TOKEN` is optional and not required. 
# If you have generated a token via `firebase login:ci` and it is 
# set in your `.env` file, it will be used for deployment. Otherwise, 
# the command will use the manual setup described above. 
# Usage: `make gen-env`
gen-env: .env
	@echo "DISABLE_TESTS=1" >> $<
	@echo "FLUTTER_BRANCH=stable" >> $<
	@echo "FIREBASE_ALIAS=default" >> $<
	@echo "FIREBASE_TOKEN=" >> $<

# Start the dev container and serve the Jekyll site. If the 
# site is not yet built, this will run build automatically
up:
	docker-compose up site

# Bring down the running dev container
down:
	docker-compose down

# Run the dev container and enter shell for debugging
debug:
	docker-compose run --rm site bash

# Enter the shell of the running dev container
shell:
	docker-compose exec site bash

# Build the dev container from scratch, overcoming 
# a funky (documented) error with installed packages 
# that may hav something to do with use of a volume
setup:
	make clean
	docker-compose build site

# Serve the Jekyll site with livereload and incremental builds
# NOTE this is run inside of the container on `make up`
serve:
	bundle exec jekyll serve \
		--host ${SITE_HOST} \
		--port ${SITE_PORT} \
		--config _config.yml,_config_dev.yml \
		--livereload \
		--incremental \
		--trace

CHANNEL ?= stable

# Switch flutter channels inside the running container
# NOTE this is experimental and compose is mirroring your 
# local flutter repo via the volume, so this may have 
# unexpected consequences on your local setup.
# Usage: `make switch-channel CHANNEL=<channel>`
switch-channel:
	
	docker-compose exec site cd flutter && \
		git remote set-branches origin ${CHANNEL} && \
  		git fetch --depth 1 origin ${CHANNEL} && \
  		git checkout ${CHANNEL} --  && \
  		git pull && \
		cd .. && \
  		flutter doctor

# Run tests against the running dev container
# NOTE this will mirror test artifacts to local
# Usage: `make test-channel CHANNEL=<channel>`
test-channel:
	docker-compose exec site tool/test.sh --target ${CHANNEL} --check-links --null-safety

# Refresh code excerpts inside the running dev container
refresh-code-excerpts:
	docker-compose exec site tool/refresh-code-excerpts.sh --keep-dart-tool

# Check code inside the running dev container, refreshing 
# snippets and running old and null-safety examples
# NOTE this will mirror test artifacts to local
# Usage: `make check-code`
check-code:
	docker-compose exec site tool/check-code.sh --refresh --null-safety

# Check links inside the running dev container
# NOTE this will mirror test artifacts to local
# Usage: `make check-links`
check-links:
	docker-compose exec site tool/check-links.sh



# =================== Build / Test / Deploy Commands ==================

FLUTTER_BRANCH ?= stable
TEST_TARGET_CHANNEL ?= stable
FIREBASE_ALIAS ?= default
BUILD_COMMIT := $(shell git rev-parse --short HEAD)
BUILD_TAG = fltbuild
BUILD_NAME = tmpbuild

# Run all tests that would be run inside the container for the 
# given target channel on the Github action `test` job.
# WARNING this can take long while to run!
# # Usage: `make test TEST_TARGET_CHANNEL=<channel>`
test:
	docker build --rm --target test \
		--build-arg TEST_TARGET_CHANNEL=${TEST_TARGET_CHANNEL} \
		--build-arg RUBY_VERSION=${RUBY_VERSION} \
		--build-arg NODE_VERSION=${NODE_VERSION} -t ${BUILD_TAG}:${BUILD_COMMIT} .

# Allows for firing up a shell with a regular build and 
# running shell scripts manually to test the build. 
# Usage `make debug-test`
debug-test:
	docker build --rm --target dev \
		--build-arg RUBY_VERSION=${RUBY_VERSION} \
		--build-arg NODE_VERSION=${NODE_VERSION} -t ${BUILD_TAG}:${BUILD_COMMIT} .
	docker run --rm -it \
		-v ${PWD}/tool:/app/tool ${BUILD_TAG}:${BUILD_COMMIT} bash
	docker rmi -f ${BUILD_TAG}:${BUILD_COMMIT}

# Build the production image
# NOTE important to disable tests with the local build as 
# those will be run on the Github action.
# Usage: `DISABLE_TESTS=1 make build-image`
build-image:
	docker build --no-cache --rm --target builder \
		--build-arg FIREBASE_ALIAS=${FIREBASE_ALIAS} \
		--build-arg FIREBASE_TOKEN=${FIREBASE_TOKEN} \
		--build-arg FLUTTER_BRANCH=${FLUTTER_BRANCH} \
		--build-arg DISABLE_TESTS=${DISABLE_TESTS} \
		--build-arg COMMIT=${BUILD_COMMIT} \
		--build-arg RUBY_VERSION=${RUBY_VERSION} \
		--build-arg NODE_VERSION=${NODE_VERSION} -t ${BUILD_TAG}:${BUILD_COMMIT} .

# Build the production image and copy site build to local. 
# This will reset and also clean up after finished. 
# NOTE important to disable tests with the local build as 
# those will be run on the Github action.
# Usage: `DISABLE_TESTS=1 make build`
build:
	make clean
	make build-image
	docker run --rm -d --name ${BUILD_NAME} -t ${BUILD_TAG}:${BUILD_COMMIT}
	docker cp ${BUILD_NAME}:/app/_site _site
	docker stop ${BUILD_NAME}
	docker rmi -f ${BUILD_TAG}:${BUILD_COMMIT}

# Deploy the Firebase hosting site from local. 
# NOTE that if you have a FIREBASE_TOKEN exported or 
# in your local `.env` file, it will be used. This style 
# is used inside the Github action.
# Usage: `make deploy`
deploy:
ifndef FIREBASE_TOKEN
	firebase deploy -m ${BUILD_COMMIT} --only hosting
else
	firebase use ${FIREBASE_ALIAS}
	firebase deploy -m ${BUILD_COMMIT} \
		--only hosting \
		--non-interactive \
		--token ${FIREBASE_TOKEN} \
		--project ${FIREBASE_ALIAS} \
		--debug \
		--json
endif

STAGE_NAME ?= stage
# All in one command to stage your build to a Firebase 
# channel on your currently selected project
# Usage: `make stage STAGE_NAME=foo`
stage:
	make build
	firebase hosting:channel:deploy ${STAGE_NAME}



# =================== Utility Commands ==================


# Clean all caches, and test/build files
clean:
	rm -rf _site .jekyll* src/.jekyll* *.log tmp example.g .dart_tool

# Helpful to reinstall all Ruby packages from inside container
reinstall:
	rm -f Gemfile.lock
	bundle install --redownload

# Purge all running containers and remove the image
purge:
	docker-compose down
	docker rm -f $(docker ps -aq)
	docker rmi flt-dev
