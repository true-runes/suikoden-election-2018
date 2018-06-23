require "capistrano/rbenv"
require 'capistrano/ndenv'

require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# require 'capistrano/yarn'

require "capistrano/rails"
require "capistrano/rails/console"
require "capistrano3/unicorn"
require 'capistrano/sidekiq'

require 'whenever/capistrano'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
