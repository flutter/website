#!make
include shared.env
-include .env

.DEFAULT_TARGET: up
.PHONY: up down debug shell setup serve build deploy stage clean reinstall

up:
	docker-compose up site

down:
	docker-compose down

debug:
	docker-compose run --rm site bash

shell:
	docker-compose exec site bash

setup:
	make clean
	docker-compose build site
	# Fun docker compose issue, install again :)
	docker-compose run site bundle install
	docker-compose run site npm install

update-submodules:
	docker-compose exec site git submodules update --recursive --remote

CHANNEL ?= stable
switch-channel:
	# Usage: make switch-channel CHANNEL=<channel>
	docker-compose exec site cd flutter && \
		git remote set-branches origin ${CHANNEL} && \
  		git fetch --depth 1 origin ${CHANNEL} && \
  		git checkout ${CHANNEL} --  && \
  		git pull && \
		cd .. && \
  		flutter doctor

test-channel:
	docker-compose exec site tool/test.sh --target ${CHANNEL} --check-links --null-safety

check-code:
	docker-compose exec site tool/check-code.sh --refresh
	docker-compose exec site tool/check-code.sh --null-safety

check-links:
	docker-compose exec site tool/check-links.sh

serve:
	bundle exec jekyll serve \
		--host ${SITE_HOST} \
		--port ${SITE_PORT} \
		--config _config.yml,_config_dev.yml \
		--livereload \
		--incremental \
		--trace


# ========= Build Commands =========

FLUTTER_BRANCH ?= stable
TEST_TARGET_CHANNEL ?= stable
FIREBASE_ALIAS ?= default
BUILD_COMMIT := $(shell git rev-parse --short HEAD)
BUILD_TAG = fltbuild
BUILD_NAME = tmpbuild

test:
	docker build --rm --target test \
		--build-arg TEST_TARGET_CHANNEL=${TEST_TARGET_CHANNEL} \
		--build-arg RUBY_VERSION=${RUBY_VERSION} \
		--build-arg NODE_VERSION=${NODE_VERSION} -t ${BUILD_TAG}:${BUILD_COMMIT} .

debug-test:
	docker build --rm --target dev \
		--build-arg RUBY_VERSION=${RUBY_VERSION} \
		--build-arg NODE_VERSION=${NODE_VERSION} -t ${BUILD_TAG}:${BUILD_COMMIT} .
	docker run --rm -it \
		-v ${PWD}/tool:/app/tool ${BUILD_TAG}:${BUILD_COMMIT} bash

build-image:
	docker build --no-cache --rm --target builder \
		--build-arg FIREBASE_ALIAS=${FIREBASE_ALIAS} \
		--build-arg FIREBASE_TOKEN=${FIREBASE_TOKEN} \
		--build-arg FLUTTER_BRANCH=${FLUTTER_BRANCH} \
		--build-arg DISABLE_TESTS=${DISABLE_TESTS} \
		--build-arg COMMIT=${BUILD_COMMIT} \
		--build-arg RUBY_VERSION=${RUBY_VERSION} \
		--build-arg NODE_VERSION=${NODE_VERSION} -t ${BUILD_TAG}:${BUILD_COMMIT} .

build:
	make clean
	make build-image
	docker run --rm -d --name ${BUILD_NAME} -t ${BUILD_TAG}:${BUILD_COMMIT}
	docker cp ${BUILD_NAME}:/app/_site _site
	docker stop ${BUILD_NAME}
	docker rmi -f ${BUILD_TAG}:${BUILD_COMMIT}

deploy:
ifndef FIREBASE_TOKEN
	firebase deploy -m ${BUILD_COMMIT} --only hosting --debug --json
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

stage:
	make build
	npx firebase hosting:channel:deploy stage

clean:
	rm -rf _site .jekyll* src/.jekyll* *.log tmp example.g .dart_tool

reinstall:
	rm -f Gemfile.lock
	bundle install --redownload

purge:
	docker-compose down
	docker rm -f $(docker ps -aq)
	docker rmi flt-dev
