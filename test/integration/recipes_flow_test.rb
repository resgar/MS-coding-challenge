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

  test "should see an error message when no recipe is found" do
    recipe = @recipes.first
    mock = Minitest::Mock.new
    def mock.find(id); end

    RecipeService.stub :new, mock do
      get "/recipes/#{recipe.id}"
      assert "p", "Something went wrong!"
    end
  end

  test "should see an error message when recipes list is empty" do
    mock = Minitest::Mock.new
    def mock.all; end

    RecipeService.stub :new, mock do
      get "/recipes"
      assert "p", "Something went wrong!"
    end
  end
end
