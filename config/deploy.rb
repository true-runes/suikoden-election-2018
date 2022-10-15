# frozen_string_literal: true

lock '~> 3.10.2'

set :application, 'suikoden_election_2018'
set :repo_url, 'https://github.com/corselia/suikoden-election-2018.git'
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets bundle]

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
set :bundle_without, 'production' # Better Errors 対策

# master.key を初回時に手動で置かないと ERROR になる
set :linked_files, ['config/master.key']

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end
