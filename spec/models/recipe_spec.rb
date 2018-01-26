require 'rails_helper'

RSpec.describe Recipe do
  context '#favorited?' do
    it 'recipe is favorite' do
      recipe = create :recipe
      user = recipe.author
      Favorite.create user: user, recipe: recipe

      result = recipe.favorited? user

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

  context '#author?' do
    it 'user is author' do
      recipe = create :recipe

      result = recipe.author? recipe.author

      expect(result).to be true
    end

    it 'recipe is not favorite' do
      recipe = create :recipe
      another_author = create :user, email: 'another_author@bol.com'
      result = recipe.author? another_author

      expect(result).to be false
    end

    it 'user is nil' do
      recipe = create :recipe
      user_nil = nil
      result = recipe.author? user_nil

      expect(result).to be false
    end
  end
end
