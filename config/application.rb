require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EbdsaWebsite
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Simple Calendar config
    config.beginning_of_week = :sunday

    # Set default time zone to PST
    config.time_zone = 'Pacific Time (US & Canada)'
    config.active_record.default_timezone = 'Pacific Time (US & Canada)'

    # Handle errors with app controller
    config.exceptions_app = self.routes
  end
end
