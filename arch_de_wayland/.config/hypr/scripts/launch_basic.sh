#!/usr/bin/env bash
# Launch application under uwsm
# Captures all arguments
# https://github.com/Vladimir-csp/uwsm

exec uwsm-app -- "$@"
