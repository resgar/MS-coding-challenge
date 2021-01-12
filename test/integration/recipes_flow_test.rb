require "test_helper"

class RecipesFlowTest < ActionDispatch::IntegrationTest
  test "can see the recipes page" do
    VCR.use_cassette("get_index") do
      get "/recipes"
      assert_select "h1", "Recipes"
    end
  end
end
