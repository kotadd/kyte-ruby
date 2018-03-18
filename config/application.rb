require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kyte
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.time_zone = 'Tokyo'
  	config.active_record.time_zone_aware_types = [:datetime, :time]
	  config.i18n.default_locale = :ja

    # config.action_mailer.default_url_options = { host: 'localhost' }
    # config.action_mailer.default_url_options = { host: 'example.com' }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
