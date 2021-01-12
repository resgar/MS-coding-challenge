class RecipesController < ApplicationController
  before_action :set_recipe, only: :show

  def index
    @recipes = RecipeService.all
  end

end
