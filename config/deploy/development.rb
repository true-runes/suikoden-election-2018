# frozen_string_literal: true

require 'dotenv/load'

set :stage, :development
set :branch, :development
set :deploy_to, ENV['DEPLOY_DIR_FOR_DEV']
set :rails_env, 'development'
server ENV['DEPLOY_SERVER'], user: ENV['DEPLOY_USER_FOR_DEV'], roles: %w[web app db batch]

set :ssh_options, {
  port: ENV['DEPLOY_SERVER_PORT'],
  forward_agent: true,
  keys: [File.expand_path(ENV['DEPLOY_KEYS_FOR_DEV'])]
}

set :whenever_roles, :batch
set :whenever_environment, :development

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.development.pid" # /tmp/pids は予約語
set :unicorn_config_path, "#{release_path}/config/unicorn.development.rb"

set :pty, false # Sidekiq
