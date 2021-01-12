require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    VCR.use_cassette("get_index") do
      get recipes_url
      assert_response :success
    end
  end

end
