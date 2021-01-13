require "test_helper"

class RecipesFlowTest < ActionDispatch::IntegrationTest

  setup do
    VCR.use_cassette("get_recipes") do
      @recipes = RecipeService.all
    end
  end

  test "can see the recipes page" do
    VCR.use_cassette("get_index") do
      get "/recipes"
      assert_select "h1", "Recipes"
    end
  end

  test "can see the recipe page" do
    recipe = @recipes.first
    VCR.use_cassette("get_show") do
      get "/recipes/#{recipe.id}"
      assert_select "h1", recipe.title
    end
  end
end
