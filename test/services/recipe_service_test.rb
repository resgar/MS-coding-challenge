require "test_helper"

class RecipeServiceTest < ActiveSupport::TestCase
  setup do
    VCR.use_cassette("get_recipes") do
      @recipes = RecipeService.all
    end
  end 

  test "should get all recipes" do
    assert_kind_of Contentful::Array, @recipes
  end

  test "should find correct recipe" do
    entry_id = @recipes.first.id
    VCR.use_cassette("get_recipe") do
      response_id = RecipeService.find(entry_id).id
      assert_equal entry_id, response_id
    end
  end
end
