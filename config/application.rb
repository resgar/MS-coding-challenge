require_relative 'boot'

require 'active_model/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MsCodingChallenge
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.before_configuration do
      env_file = Rails.root.join('config/local_env.yml')

      if File.exist?(env_file)
        YAML
          .safe_load(File.open(env_file))
          .each { |key, value| ENV[key.to_s] = value }
      end
    end

    # Initialize Cotentful client
    config.after_initialize do
      contentful_config = config_for(:contentful).merge(
        logger: ActiveSupport::Logger.new("log/#{Rails.env}.log"),
        dynamic_entries: :auto
      )

      config.contentful_client = begin
        Contentful::Client.new(contentful_config)
      rescue StandardError => e
        Rails.logger.error e.inspect
        nil
      end
    end

    config.autoload_paths += %W[#{config.root}/app/services]
  end
end
