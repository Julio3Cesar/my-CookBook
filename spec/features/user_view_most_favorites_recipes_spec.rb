require 'rails_helper'

feature 'User view most favorites recipes' do 
  scenario 'successfully' do 
    cuisine = FactoryBot.create :cuisine
    recipe_type = FactoryBot.create :recipe_type
    user_1 = FactoryBot.create :user
    user_2 = FactoryBot.create :user, email: 'author@email.com'
    user_3 = FactoryBot.create :user, email: 'another_user@email.com'
    most_favorites_recipes = FactoryBot.create_list :recipe, 3, cuisine: cuisine, recipe_type: recipe_type, author: user_1
    another_recipes = FactoryBot.create_list :recipe, 3, title: 'anotherRecipes', cuisine: cuisine, recipe_type: recipe_type, author: user_1
    Favorite.create user: user_1, recipe: most_favorites_recipes[0]
    Favorite.create user: user_2, recipe: most_favorites_recipes[0]
    Favorite.create user: user_3, recipe: most_favorites_recipes[0]
    Favorite.create user: user_1, recipe: most_favorites_recipes[1]
    Favorite.create user: user_2, recipe: most_favorites_recipes[1]
    Favorite.create user: user_1, recipe: most_favorites_recipes[2]
    Favorite.create user: user_2, recipe: most_favorites_recipes[2]
    
    Favorite.create user: user_1, recipe: another_recipes[0]
    Favorite.create user: user_2, recipe: another_recipes[1]
    Favorite.create user: user_2, recipe: another_recipes[2]

    visit root_path 
    
    most_favorites_recipes.each do |m|
      expect(page).to have_css('div.most-favorite', text: m.title)
    end

    another_recipes.each do |n|
      expect(page).not_to have_css('div.most-favorite', text: n.title)
    end
  end

  scenario 'but not favorites' do 
    cuisine = FactoryBot.create :cuisine
    recipe_type = FactoryBot.create :recipe_type
    user_1 = FactoryBot.create :user
    recipes = FactoryBot.create_list :recipe, 6, cuisine: cuisine, recipe_type: recipe_type, author: user_1

    visit root_path 
    
    expect(page).to have_css('div.most-favorite', text: 'Nenhuma receita favoritada')
    
    recipes.each do |m|
      expect(page).not_to have_css('div.most-favorite', text: m.title)
    end
  end

  scenario 'two favorites recipes' do 
    cuisine = FactoryBot.create :cuisine
    recipe_type = FactoryBot.create :recipe_type
    user_1 = FactoryBot.create :user
    user_2 = FactoryBot.create :user, email: 'sasa@bol.com'
    recipe = FactoryBot.create :recipe,  title: 'primeira', cuisine: cuisine, recipe_type: recipe_type, author: user_1
    recipe2 = FactoryBot.create :recipe, title: 'segunda', cuisine: cuisine, recipe_type: recipe_type, author: user_1
    Favorite.create user: user_1, recipe: recipe
    Favorite.create user: user_2, recipe: recipe
    Favorite.create user: user_1, recipe: recipe2

    visit root_path 
    
    expect(page).to have_css('div.most-favorite', text: recipe.title)
    expect(page).to have_css('div.most-favorite', text: recipe2.title)

  end
end