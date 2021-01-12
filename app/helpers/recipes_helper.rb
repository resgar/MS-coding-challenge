module RecipesHelper
  def photo_url(recipe)
    recipe.fields[:photo].image_url(
      width: 300,
      height: 200,
      format: 'jpg',
      quality: 100
    ).sub %r{\A//}, 'https://'
  end
end
