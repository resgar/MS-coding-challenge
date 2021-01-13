require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest

  setup do
    VCR.use_cassette("get_recipes") do
      @recipes = RecipeService.all
    end
  end

  test "should get index" do
    VCR.use_cassette("get_index") do
      get recipes_url
      assert_response :success
    end
  end

  test "should show recipe" do
    VCR.use_cassette("get_show") do
      get recipe_url(@recipes.first.id)
      assert_response :success
    end
  end
end
