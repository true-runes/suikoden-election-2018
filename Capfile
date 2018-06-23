require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

require "capistrano/rails"
require "capistrano/rails/console"
require "capistrano/rbenv"
require "capistrano3/unicorn"
require 'capistrano/yarn'
require 'capistrano/sidekiq'
require 'whenever/capistrano'
require 'capistrano/ndenv'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
