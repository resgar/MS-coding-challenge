class RecipesController < ApplicationController
  before_action :set_recipe, only: :show

  def index
    recipes = RecipeService.all

    if recipes
      @decorated_recipes = recipes.map { |recipe| RecipeDecorator.new(recipe) }
    else
      render status: :not_found
    end
  end

  def show
    @decorated_recipe = RecipeDecorator.new(@recipe)
  end

  private
    def set_recipe
      @recipe = RecipeService.find(params[:id])
      render status: :not_found unless @recipe
    end
end
