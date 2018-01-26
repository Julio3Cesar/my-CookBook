require 'rails_helper'

feature 'User view star in favorites recipes' do
  scenario 'in show page, success' do
    user = create :user, email: 'aspergesme@gmail.com'
    recipe = create :recipe
    Favorite.create user: user, recipe: recipe

    login_as user
    visit recipe_path recipe

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css("img[alt='Star']")
  end

  scenario 'in home page, success' do
    user = create :user, email: 'aspergesme@gmail.com'
    recipe = create :recipe
    Favorite.create user: user, recipe: recipe

    login_as user
    visit root_path

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css("img[alt='Star']")
  end

  scenario 'in view all recipes page, success' do
    user = create :user, email: 'aspergesme@gmail.com'
    recipe = create :recipe
    Favorite.create user: user, recipe: recipe

    login_as user
    visit recipes_path

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css("img[alt='Star']")
  end

  scenario 'in show page, fail' do
    user = create :user, email: 'aspergesme@gmail.com'
    recipe = create :recipe

    login_as user
    visit recipe_path recipe

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_css("img[alt='Star']")
  end

  scenario 'in home page, fail' do
    user = create :user, email: 'aspergesme@gmail.com'
    recipe = create :recipe

    login_as user
    visit root_path

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_css("img[alt='Star']")
  end

  scenario 'in home page, not logged, fail' do
    user = create :user, email: 'aspergesme@gmail.com'
    recipe = create :recipe
    Favorite.create user: user, recipe: recipe

    visit root_path

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_css("img[alt='Star']")
  end

  scenario 'in home page, not logged, fail' do
    user = create :user, email: 'aspergesme@gmail.com'
    recipe = create :recipe
    Favorite.create user: user, recipe: recipe

    visit recipe_path recipe

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_css("img[alt='Star']")
  end

  scenario 'user not view in all favorites page' do
    user = create :user, email: 'aspergesme@gmail.com'
    recipe = create :recipe
    Favorite.create user: user, recipe: recipe

    login_as user
    visit favorites_recipes_path

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_css("img[alt='Star']")
  end
end
