require "rails_helper"

RSpec.describe Recipe do 
  context '#favorited?' do 
    it 'recipe is favorite' do 
      recipe = create :recipe
      user = recipe.author
      Favorite.create user: user, recipe: recipe

      result =recipe.favorited? user

      expect(result).to be true
    end

    it 'recipe is not favorite' do 
      recipe = create :recipe
      user = recipe.author

      result = recipe.favorited? user

      expect(result).to be false
    end

    it 'user is nil' do 
      recipe = create :recipe
      user = nil
      result = recipe.favorited? user

      expect(result).to be false
    end
  end
end