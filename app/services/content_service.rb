class ContentService
  attr_reader :type

  def initialize(type: 'recipe')
    @type = type
  end

  # Returns all entries
  def all
    client.entries(content_type: type)
  end

  # Finds a specific entry
  def find(contentful_id)
    client.entries(:content_type => type, 'sys.id' => contentful_id).first
  end

  private

  def client
    @client ||=
      Contentful::Client.new(
        access_token: ENV['CONTENTFUL_ACCESS_TOKEN'],
        space: ENV['CONTENTFUL_SPACE_ID'],
        dynamic_entries: :auto,
        raise_errors: true
      )
  end
end
