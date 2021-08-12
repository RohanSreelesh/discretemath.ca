#!/bin/bash
set -e

env

# Remove a potentially pre-existing server.pid for Rails.
rm -f tmp/pids/server.pid

RAILS_ENV=production bundle exec rails credentials:edit
RAILS_ENV=production bundle exec rails db:setup --trace

# Then exec the container's main process (what's set as CMD in the Dockerfile).
bundle exec rails s -p 3000 -b '0.0.0.0' -e production
