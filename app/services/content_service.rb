# Get any content through Contentful APIs based on the given content_type
class ContentService
  def initialize(type:)
    @type = type
  end

  # Returns all entries
  def all
    Rails.cache.fetch("contentful_entries", expires_in: 30.minutes, skip_nil: true) do
      contentful_client.entries(content_type: type)
    end
  rescue StandardError => e
    Rails.logger.error e.inspect
    nil
  end

  # Finds a specific entry
  def find(contentful_id)
    Rails.cache.fetch("#{contentful_id}/contentful_entry", expires_in: 30.minutes, skip_nil: true) do
      contentful_client.entry(contentful_id)
    end
  rescue StandardError => e
    Rails.logger.error e.inspect
    nil
  end

  class << self
    delegate :all, :find, to: :new
  end

  private

  attr_reader :type, :client

  def contentful_client
    Rails.application.config.contentful_client
  end
end
