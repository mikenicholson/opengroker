#!/usr/bin/env bash

# Cron doesn't pass environment variables to scripts it runs
# To work around this we dump the environment to a file when
# the container starts.
source /tmp/myEnv.sh

if [ ! -d "$OPENGROK_SOURCE_DIR" ]; then
    mkdir -p "$OPENGROK_SOURCE_DIR"
fi

/opengrok/bin/OpenGrok index "$OPENGROK_SOURCE_DIR"
