set :stage, :production
set :branch, :master
set :deploy_to, '/home/deploy_gss_2018_production/deploy/suikoden-election-2018' # ここも隠したい
set :rails_env, 'production'
server Rails.application.credentials.deploy[:production][:server], user: Rails.application.credentials.deploy[:production][:user], roles: %w{web app db batch}

set :ssh_options, {
  port: Rails.application.credentials.deploy[:production][:port],
  forward_agent: true,
  keys: [File.expand_path(Rails.application.credentials.deploy[:production][:keys])],
}

set :whenever_roles, :batch
set :whenever_environment, :production

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.production.pid"
set :unicorn_config_path, "#{release_path}/config/unicorn.production.rb"

set :pty, false # Sidekiq