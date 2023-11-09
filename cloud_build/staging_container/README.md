This directory contains a Dockerfile that is used for staging the website. The
following tools are installed to make staging easier:

* Github CLI
* Node/NPM
* Firebase Tools

This Dockerfile is currently WIP. The cloud build template in this directory is
currently manually triggered to build an image and deploy it to Artifact
Registry, but it can be configured in the future to build automatically on any
changes to the Dockerfile or cloudbuild template.