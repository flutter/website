#!/usr/bin/env bash

# Bash script to generate argument variables for the host user in the Docker 
# user-base image.
# This is done to avoid file ownership issues on the host side.
# Used inside `make genenv` command.
# Usage - `./tool/genenv-host-user.sh $(pwd)/.env`
# $1 - path to the .env file

HOST_KERNEL_NAME=$(uname -s)
echo HOST_KERNEL_NAME=$HOST_KERNEL_NAME >> $1

if [[ $HOST_KERNEL_NAME == Darwin || $HOST_KERNEL_NAME == Linux ]]; then
  echo HOST_GROUP_ID=$(id -g) >> $1
  echo HOST_GROUP_NAME=$(id -gn) >> $1
  echo HOST_USER_ID=$(id -u) >> $1
  echo HOST_USER_HOME=$HOME >> $1
  echo HOST_USER_NAME=$(id -un) >> $1
else
  echo HOST_GROUP_ID=0 >> $1
  echo HOST_USER_ID=0 >> $1
  echo HOST_USER_HOME=/root >> $1
fi
