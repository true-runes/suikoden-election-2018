lock "~> 3.10.2"

set :application, 'suikoden_election_2018'
set :repo_url, 'https://github.com/corselia/suikoden-election-2018.git'
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets bundle)

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'
set :ndenv_type, :user
set :ndenv_node, '10.5.0'
set :yarn_target_path, -> { release_path.join('bin/yarn') } #=> なぜ /user/bin/env になるかというとそこへのエイリアス？

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# master.key を初回時に手動で置かないと ERROR になる
set :linked_files, ['config/master.key']

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end