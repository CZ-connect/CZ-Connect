#!/bin/sh

# Abort on any error (including if wait-for-it fails).
set -e

# Wait for the backend to be up, if we know where it is.
if [ -n "$WAIT_FOR_HOST" ]; then
  /usr/src/app/wait-for-it.sh --timeout=30 "$WAIT_FOR_HOST:${ON_PORT:-6000}"
fi

# Run the main container command.
exec "$@"
