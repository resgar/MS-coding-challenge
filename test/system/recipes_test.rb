require "application_system_test_case"

class RecipesTest < ApplicationSystemTestCase

  test "visiting the index" do
    VCR.use_cassette("get_index") do
      visit recipes_url
      assert_selector "h1", text: "Recipes"
    end
  end

end
