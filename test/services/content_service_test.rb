require "test_helper"

class ContentServiceTest < ActiveSupport::TestCase

  setup do
    @content_service = ContentService.new(type: 'recipe')
    @recipes = @content_service.all
  end 

  test "render_all should return an array" do
    assert_kind_of Contentful::Array, @recipes
  end

  test "recipe should have correct format" do
    recipe = @content_service.find(@recipes.first.id)
    assert_kind_of Contentful::Entry, recipe
  end
end
