set :stage, :development
set :branch, :development
set :deploy_to, '/home/deploy_gss_2018_development/deploy/suikoden-election-2018' # ここも隠したい
set :rails_env, 'development'
Rails.application.credentials.deploy[:development][:server], user: Rails.application.credentials.deploy[:development][:user], roles: %w{web app db batch}

set :ssh_options, {
  port: Rails.application.credentials.deploy[:development][:port],
  forward_agent: true,
  keys: [File.expand_path(Rails.application.credentials.deploy[:development][:keys])],
}

set :whenever_roles, :batch
set :whenever_environment, :development

set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.development.pid" # /tmp/pids は予約語
set :unicorn_config_path, "#{release_path}/config/unicorn.development.rb"

set :pty, false # Sidekiq

set :bundle_without, 'production' # これがないと BETTOR ERRORS が require されないようだ？
# https://stackoverflow.com/questions/21841044/capistrano-not-using-rails-environment-with-bundler-properly
