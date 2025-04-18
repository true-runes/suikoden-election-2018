# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '3.2.2'

gem 'activeadmin'
gem 'active_model_serializers'
gem 'activerecord-import'
gem 'annotate'
gem 'base64'
gem 'bigdecimal'
gem 'bootsnap', require: false
gem 'brakeman'
gem 'bullet'
gem 'bundler-audit'
gem 'chartkick'
gem 'default_value_for'
gem 'devise'
gem 'dotenv-rails'
gem 'draper'
gem 'faraday'
gem 'foreman'
gem 'global'
gem 'google_drive'
gem 'groupdate'
gem 'jbuilder'
gem 'jp_prefecture'
gem 'kaminari'
gem 'money-rails'
gem 'paranoia'
gem 'pg'
gem 'puma'
gem 'rails'
gem 'ransack'
gem 'rest-client'
gem 'retryable'
gem 'rubocop'
gem 'rufo'
gem 'sass-rails'
gem 'search_cop'
gem 'seed-fu'
gem 'shrine'
gem 'simplecov'
gem 'simple_form'
gem 'slim-rails'
gem 'smarter_csv'
gem 'twitter'
gem 'uglifier'
gem 'unicorn'
gem 'upsert'
gem 'webpacker'
gem 'whenever'

group :development, :test do
  gem 'awesome_print'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'listen'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rubocop-rails'
end

group :development do
  gem 'capistrano'
  gem 'capistrano3-unicorn'
  gem 'capistrano-bundler'
  gem 'capistrano-ndenv'
  gem 'capistrano-rails'
  gem 'capistrano-rails-console', require: false
  gem 'capistrano-rbenv'
  gem 'capistrano-sidekiq'
  gem 'capistrano-yarn'
  gem 'database_cleaner'
  gem 'database_rewinder'
  gem 'faker'
  gem 'json_spec'
  gem 'rack-mini-profiler'
  gem 'timecop'
  gem 'vcr'
  gem 'web-console'
  gem 'webmock'
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'rspec-json_matcher'
  gem 'rspec-parameterized'
  gem 'rspec-rails', require: false
  gem 'rspec-request_describer'
  gem 'rspec-retry'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
