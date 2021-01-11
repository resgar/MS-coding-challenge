require "test_helper"

class RecipeServiceTest < ActiveSupport::TestCase

  setup do
    @recipes = RecipeService.all
  end 

  test "should get all recipies" do
    assert_kind_of Contentful::Array, @recipes
  end

  test "should find correct recipe" do
    entry_id = @recipes.first.id
    response_id = RecipeService.find(entry_id).id
    assert_equal entry_id, response_id
  end
end
