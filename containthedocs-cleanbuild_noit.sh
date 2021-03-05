#!/usr/bin/env bash

set -x

COMMAND="make -C docs clean html"

. ./containthedocs-image

# removed the '-it' option, so this will not run interactively.
#exec docker run --rm -it \
exec docker run --rm \
  -v "$PWD":"$PWD" --workdir "$PWD" \
  ${DOCKER_RUN_ARGS} \
  -e "LOCAL_USER_ID=$(id -u)" \
  ${DOC_IMG} ${COMMAND}
