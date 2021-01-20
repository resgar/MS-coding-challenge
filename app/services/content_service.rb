# Get any content through Contentful APIs based on the given content_type
module ContentService
  attr_accessor :type

  class Client
    include Singleton
  
    attr_reader :client
  
    def initialize
      contentful_config = Rails.application.config_for(:contentful).merge(
        logger: ActiveSupport::Logger.new("log/#{Rails.env}.log"),
        dynamic_entries: :auto
      )
      @client = Contentful::Client.new(contentful_config)
    end
  end

  # Returns all entries
  def all
    Rails.cache.fetch("contentful_entries", expires_in: 30.minutes, skip_nil: true) do
      client.entries(content_type: type)
    end
  rescue StandardError => e
    Rails.logger.error e.inspect
    nil
  end

  # Finds a specific entry
  def find(contentful_id)
    Rails.cache.fetch("#{contentful_id}/contentful_entry", expires_in: 30.minutes, skip_nil: true) do
      client.entry(contentful_id)
    end
  rescue StandardError => e
    Rails.logger.error e.inspect
    nil
  end

  def client
    Client.instance.client
  end
end
