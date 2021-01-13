require "application_system_test_case"

class RecipesTest < ApplicationSystemTestCase

  setup do
    VCR.use_cassette("get_recipes") do
      @recipes = RecipeService.all
    end
  end

  test "visiting the index" do
    VCR.use_cassette("get_index") do
      visit recipes_url
      assert_selector "h1", text: "Recipes"
    end
  end

  test "visiting the show" do
    VCR.use_cassette("get_show") do
      recipe = @recipes.first
      visit recipe_url(recipe.id)
      assert_selector "h1", text: recipe.title
    end
  end
end
