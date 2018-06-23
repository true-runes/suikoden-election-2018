require 'dotenv/load'

set :stage, :production
set :branch, :master
set :deploy_to, ENV["DEPLOY_DIR_FOR_PRODUCTION"]
set :rails_env, 'production'
server ENV["DEPLOY_SERVER"], user: ENV["DEPLOY_USER_FOR_PRODUCTION"], roles: %w{web app db} # wheneverは無効化

set :ssh_options, {
  port: ENV["DEPLOY_SERVER_PORT"],
  forward_agent: true,
  keys: [File.expand_path(ENV["DEPLOY_KEYS_FOR_PRODUCTION"])],
}

set :whenever_roles, :batch
set :whenever_environment, :production

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.production.pid"
set :unicorn_config_path, "#{release_path}/config/unicorn.production.rb"

set :pty, false # Sidekiq