require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SuikodenElection2018
  class Application < Rails::Application
    config.load_defaults 5.2

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :utc
    config.generators.template_engine = :slim

    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    # 10M のファイルを 10個 まで
    # config.logger = Logger.new('log/development.log', 10, 10 * 1024 * 1024)
    # config.logger = Logger.new('log/production.log', 10, 10 * 1024 * 1024)
    # config.logger = Logger.new('log/sidekiq.log', 10, 10 * 1024 * 1024)
    # config.logger = Logger.new('log/unicorn_production_stderr.log', 10, 10 * 1024 * 1024)
    # config.logger = Logger.new('log/unicorn_production_stdout.log', 10, 10 * 1024 * 1024)
    # config.logger = Logger.new('log/unicorn_development_stderr.log', 10, 10 * 1024 * 1024)
    # config.logger = Logger.new('log/unicorn_development_stdout.log', 10, 10 * 1024 * 1024)
    # config.logger = Logger.new('log/whenever.log', 10, 10 * 1024 * 1024)
  end
end
