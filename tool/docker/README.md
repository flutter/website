This directory includes scripts to build the docker container image used for
building flutter/website in our CI system (currently [Cirrus](cirrus-ci.org)).

In order to run the scripts, you have to setup `docker` and `gcloud`. Please
refer to the [internal flutter team doc](go/flutter-team) for how to setup in a
Google internal environment.

After setup,
* edit `Dockerfile` to change how the container image is built.
* run `./build_docker.sh` to build the container image.
* run `./push_docker.sh` to push the image to google cloud registry. This will
  affect our CI tests.

Gemfile and Gemfile.lock are used by the Docker setup to install particular
versions of Ruby gems that are used by the website tests. If you need to install
gems locally, you'll need to do it from this directory.

If you aren't on a workstation that can run Docker, you can trigger an update to
the docker image by tagging a particular ref in git and pushing it to the
upstream repo.

```bash
git tag -a latest -m "Latest website version"
git push upstream latest
```

You can see uploaded Docker containers and their tags on the
[Google Container Registry](https://pantheon.corp.google.com/gcr/images/flutter-cirrus/GLOBAL/build-website-image)
console.

Currently, the only tagged container is `latest`, and that's the tag that is
applied by the scripts in this directory by default, and the one referenced in
the [`.cirrus.yml` file](../../.cirrus.yml).
