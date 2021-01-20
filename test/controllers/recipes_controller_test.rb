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

  test "should get show recipe" do
    VCR.use_cassette("get_show") do
      get recipe_url(@recipes.first.id)
      assert_response :success
    end
  end

  test "should return error when recipes is nil" do
    mock = Minitest::Mock.new
    def mock.all; end

    RecipeService.stub :new, mock do
      get recipes_url
      assert_response :not_found
    end
  end

  test "should return error when recipe is nil" do
    recipe = @recipes.first
    mock = Minitest::Mock.new
    def mock.find(id); end

    RecipeService.stub :new, mock do
      get recipe_url(recipe)
      assert_response :not_found
    end
  end
end
