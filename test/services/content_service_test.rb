require "test_helper"

class ContentServiceTest < ActiveSupport::TestCase
  setup do
    VCR.use_cassette("get_recipes") do
      @content_service = ContentService.new(type: 'recipe')
      @entries = @content_service.all
    end
  end 

  test "should get all entries" do
    assert_kind_of Contentful::Array, @entries
  end

  test "should find correct entry" do
    entry_id = @entries.first.id
    VCR.use_cassette("get_recipe") do
      response_id = @content_service.find(entry_id).id
      assert_equal entry_id, response_id
    end
  end
end
