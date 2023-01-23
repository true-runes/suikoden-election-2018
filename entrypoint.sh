#!/bin/bash
set -e

RAILS_PORT=3000
if [ -n "$PORT" ]; then
  RAILS_PORT=$PORT
fi

rm -f tmp/pids/server.pid

bin/rails s -p $RAILS_PORT -b 0.0.0.0
