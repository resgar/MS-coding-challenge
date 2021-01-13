class RecipesController < ApplicationController
  before_action :set_recipe, only: :show

  def index
    @recipes = RecipeService.all
  end

  def show; end

  private
    def set_recipe
      @recipe = RecipeService.find(params[:id])
    end
end
