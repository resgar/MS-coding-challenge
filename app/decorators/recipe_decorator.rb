class RecipeDecorator
  attr_accessor :recipe
  delegate :id, to: :recipe

  def initialize(recipe)
    @recipe = recipe
  end

  # Return the url of recipe image
  # @param Contentful::Entry[recipe]
  # @return String
  def photo_url
    recipe.fields[:photo].image_url(
      width: 300,
      height: 200,
      format: 'jpg',
      quality: 100
    ).sub %r{\A//}, 'https://'
  end

  # Retrives recipe's title
  # @param Contentful::Entry[recipe]
  # @return String
  def title
    recipe.fields&.fetch(:title, 'No title')&.truncate(70)
  end

  # Retrives chef name
  # @param Contentful::Entry[recipe]
  # @return String
  def chef_name
    recipe.fields&.[](:chef).try(:name)
  end

  # Retrives recipe's tags
  # @param Contentful::Entry[recipe]
  # @return [Contentful::Entry[tag]]
  def tags
    recipe.fields[:tags].map { |tag| tag.fields&.[](:name)&.capitalize }
  end

  # Retrives description of a recipe. Returns a default value
  # if there is no description
  # @param Contentful::Entry[recipe]
  # @return String
  def description
    recipe.fields&.fetch(:description, 'No description')
  end
end