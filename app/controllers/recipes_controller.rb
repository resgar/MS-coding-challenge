class RecipesController < ApplicationController
  before_action :set_recipe, only: :show

  def index
    @recipes = RecipeService.all
    render status: :not_found unless @recipes
  end

  def show; end

  private
    def set_recipe
      @recipe = RecipeService.find(params[:id])
      render status: :not_found unless @recipe
    end
end
