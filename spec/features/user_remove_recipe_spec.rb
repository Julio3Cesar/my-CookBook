require 'rails_helper'

feature 'User remove recipe' do
  scenario 'successfully' do
    # setup
    recipe = create(:recipe)

    # navigator
    login_as recipe.author
    visit recipe_path recipe
    click_on 'Remover'

    # expect
    expect(page).to have_current_path(root_path)
    expect(page).not_to have_css('h1', text: recipe.title)
  end

  scenario 'and view root path' do
    # setup
    recipe = create(:recipe)

    # navigator
    login_as recipe.author
    visit recipe_path recipe
    click_on 'Remover'
    visit root_path

    # expect
    expect(page).not_to have_css('h1', text: recipe.title)
  end

  scenario '(another case)and view minhas receitas favoritas' do
    # setup
    recipe = create(:recipe)
    recipe2 = create(:recipe, title: 'qualquer bolo',
                              recipe_type: recipe.recipe_type, cuisine: recipe.cuisine, author: recipe.author)

    # navigator
    login_as recipe.author
    visit recipe_path recipe
    click_on 'Remover'
    visit root_path

    # expect
    expect(page).not_to have_css('h1', text: recipe.title)
    expect(page).to have_css('h1', text: recipe2.title)
  end

  scenario 'and not logged' do
    # setup
    recipe = create(:recipe)

    # navigator
    visit recipe_path recipe

    # expect
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_link('Remover')
  end

  scenario 'but not author' do
    # setup
    recipe = create(:recipe)
    user = create :user, email: 'bobpp@bol.com'

    # navigator
    login_as user
    visit recipe_path recipe

    # expect
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_link('Remover')
  end
end
