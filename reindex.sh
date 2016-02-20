#!/usr/bin/env bash

if [ ! -d "$OPENGROK_SOURCE_DIR" ]; then
    mkdir -p "$OPENGROK_SOURCE_DIR"
fi

/opengrok/bin/OpenGrok index "$OPENGROK_SOURCE_DIR"
