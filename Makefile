#!/usr/bin/make -f
-include .env


all: gen-env up down debug shell setup serve emulate test debug-tests \
		 stop-tests build-image build build-image-and-check-links debug-build \ 
		 deploy stage-channel stage-local clean reinstall purge

.DEFAULT_GOAL := up
.PHONY: all

BUILD_COMMIT := $(shell git rev-parse --short HEAD)
BUILD_CONFIGS ?= _config.yml
BUILD_NAME = tmpbuild
BUILD_TAG = "fltbuild:${BUILD_COMMIT}"
FIREBASE_ALIAS ?= default
FLUTTER_BUILD_BRANCH ?= stable
FLUTTER_TEST_BRANCH ?= stable
JEKYLL_SITE_HOST ?= 0.0.0.0
JEKYLL_SITE_PORT ?= 4002
STAGE_NAME ?= docs


# =================== Development Commands ==================

# Generate .env file with defaults
# The .env file is used to store local secrets and settings
# NOTE that using a `FIREBASE_TOKEN` is optional and not required. 
# If you have generated a token via `firebase login:ci` and it is 
# set in your `.env` file, it will be used for deployment. Otherwise, 
# the command will use the manual setup described above. 
# Usage: `make genenv`
.env:
	touch $@
genenv: .env
	@echo "FLUTTER_BUILD_BRANCH=stable" >> $<
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

# Enter the shell of the *running* dev container
shell:
	docker-compose exec site bash

# Build the dev container from scratch.
# Runs packages installs a second time for both Gems and NPM to 
# overcome inconsistent bugs with missing packages at runtime.
setup:
	make clean
	docker-compose build --no-cache site
	docker-compose run --rm site npm install
	docker-compose run --rm site bundle config set force_ruby_platform true
	docker-compose run --rm site bundle install

# Serve the Jekyll site with livereload and incremental builds
# NOTE this is run inside of the container on `make up`
serve:
	bundle exec jekyll serve \
		--host ${JEKYLL_SITE_HOST} \
		--port ${JEKYLL_SITE_PORT} \
		--config _config.yml,_config_dev.yml \
		--livereload \
		--livereload_port 37530 \
		--incremental \
		--trace

# Test hosting locally with FB emulator
emulate:
	firebase emulators:start --only hosting --project ${FIREBASE_ALIAS}


# =================== Build / Test / Deploy Commands ==================

# Run all tests that would be run inside the container for the 
# given target channel on the Github action `test` job.
# WARNING this can take a while to run!
# Usage: `make test FLUTTER_TEST_BRANCH=<channel>`
test:
	DOCKER_BUILDKIT=1 time docker build --rm --target tests -t flt-test .
	docker run --rm --name flt-tests -t flt-test --target ${FLUTTER_TEST_BRANCH}

# Stop long running tests
# Usage `make stop-tests`
stop-tests:
	docker stop flt-tests

# Allows for firing up a shell with a regular build and 
# running shell scripts manually to test the build. 
# Usage `make debug-tests`
debug-tests:
	DOCKER_BUILDKIT=1 docker build --rm --target flutter -t flt-test .
	docker run --rm -it -v ${PWD}:/app flt-test bash
	docker rmi --name flt-tests -f flt-test

# Build the production site
# NOTE important to disable tests with the local build as 
# those will be run on the Github action.
# Usage: `make build-image`
build-image:
	DOCKER_BUILDKIT=1 time docker build --rm --no-cache --target build \
		--build-arg BUILD_CONFIGS=${BUILD_CONFIGS} -t ${BUILD_TAG} .

# Build the production site & Run the link checker
# Usage: `make check-links`
build-image-and-check-links:
	DOCKER_BUILDKIT=1 time docker build --rm --no-cache --target checklinks \
		--build-arg BUILD_CONFIGS=${BUILD_CONFIGS} -t ${BUILD_TAG} .
	docker run --rm -t ${BUILD_TAG}

# Hit the shell on the built site imag
# This requires that a build:commit image has been built
# Usage: `make debug-build`
debug-build:
	docker run --rm -it -v ${PWD}:/app ${BUILD_TAG} bash

# Build the production image and copy site build to local. 
# This will reset and also clean up after finished. 
# NOTE important to disable tests with the local build as 
# those will be run on the Github action.
# Usage: `make build`
build:
	make clean
	make build-image-and-check-links
	docker run --rm -d --name ${BUILD_NAME} -t ${BUILD_TAG}
	docker cp ${BUILD_NAME}:/app/_site _site
	docker stop ${BUILD_NAME}
	docker rmi -f ${BUILD_TAG}

# Deploy the Firebase hosting site from local. 
# NOTE that if you have a FIREBASE_TOKEN exported or 
# in your local `.env` file, it will be used. This style 
# is used inside the Github action.
# Usage: `make deploy`
deploy:
ifndef FIREBASE_TOKEN
    ifeq ("${FIREBASE_ALIAS}", "default")
		firebase deploy -m ${BUILD_COMMIT} --only hosting
    else
		firebase deploy -m ${BUILD_COMMIT} \
			--only hosting \
			--project ${FIREBASE_ALIAS}
    endif
else
	firebase use ${FIREBASE_ALIAS}
	firebase deploy -m ${BUILD_COMMIT} \
		--only hosting \
		--non-interactive \
		--token ${FIREBASE_TOKEN} \
		--project ${FIREBASE_ALIAS} \
		--debug
endif

# All in one command to stage your build to a Firebase 
# channel on your currently selected project
# Usage: `make stage-channel STAGE_NAME=foo`
stage-channel:
	make build BUILD_CONFIGS=_config.yml,_config_stage.yml
	firebase hosting:channel:deploy ${STAGE_NAME} \
		--project ${FIREBASE_ALIAS}

# Utilizes the currently setup dev container or starts one.
# Then builds your site, configured for firebase staging.
# Then deploys to either the project configured with `firebase use`
# or to a specific project specified through `FIREBASE_ALIAS`.
# Usage: `make stage-local FIREBASE_ALIAS=sz-flutter-dev`
stage-local:
	make clean
	docker-compose run --rm site bundle exec jekyll build \
		--config _config.yml,_config_stage.yml
	make deploy


# =================== Utility Commands ==================

# Clean all caches, and test/build files
clean:
	rm -rf _site .jekyll* src/.jekyll* *.log tmp .dart_tool

# Helpful to reinstall all Ruby packages from inside container
reinstall:
	rm -f Gemfile.lock
	bundle install --redownload

# Purge all running containers and remove the image
purge:
	docker-compose down
	docker rm -f $(docker ps -aq)
	docker rmi flt-dev
