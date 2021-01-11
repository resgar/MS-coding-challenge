# Get recipes from Contentful
class RecipeService < ContentService
  def initialize
    super(type: 'recipe')
  end
end
