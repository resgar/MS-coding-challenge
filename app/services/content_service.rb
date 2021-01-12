# Get any content through Contentful APIs based on the given content_type
class ContentService
  def initialize(type:)
    @type = type
    @client =
      Contentful::Client.new(
        access_token: ENV['CONTENTFUL_ACCESS_TOKEN'],
        space: ENV['CONTENTFUL_SPACE_ID'],
        dynamic_entries: :auto,
        raise_errors: true
      )
  end

  # Returns all entries
  def all
    client.entries(content_type: type)
  end

  # Finds a specific entry
  def find(contentful_id)
    client.entry(contentful_id)
  end

  class << self
    delegate :all, :find, to: :new
  end

  private

  attr_reader :type, :client
end
