require 'rails_helper'

feature 'User favorite recipe' do
  scenario 'successfully' do 
    #setup 
    user = create(:user)
    recipe = create(:recipe, title: 'Bolo de fubá', author: user)

    #navigator 
    login_as user
    visit recipe_path recipe
    click_on 'Favoritar'

    #expect
    expect(page).to have_content('Adicionado aos favoritos com sucesso!')
    expect(page).not_to have_link('Favoritar')
    expect(page).to have_link('Desfavoritar')
  end

  scenario 'and view minhas receitas favoritas' do 
    #setup 
    user = create(:user)
    recipe = create(:recipe, title: 'Bolo de fubá', author: user)

    #navigator 
    login_as user
    visit root_path
    click_on recipe.title
    click_on 'Favoritar'
    click_on 'Minhas Receitas Favoritas'

    #expect
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.author.email)
  end

  scenario 'from another author' do 
    #setup 
    recipe = create(:recipe, title: 'Bolo de fubá')
    user = create(:user, email: 'another_user@bol.com')
    Favorite.create(user: user, recipe: recipe)

    #navigator 
    login_as user
    visit favorites_recipes_path

    #expect
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.author.email)
  end

  scenario 'but not this recipe' do 
    #setup 
    recipe = create(:recipe, title: 'Bolo de fubá')
    Favorite.create(user: recipe.author, recipe: recipe)
    user = create(:user, email: 'another_user@bol.com')

    #navigator 
    login_as user
    visit favorites_recipes_path

    #expect
    expect(page).to have_content('Nenhuma receita favorita!')
    expect(page).not_to have_css('h1', text: recipe.title)
  end

  scenario 'but not logged' do 
    #setup 
    recipe = create(:recipe, title: 'Bolo de fubá')

    #navigator 
    visit recipe_path recipe

    #expect
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_link('Favoritar')
    expect(page).not_to have_link('Desfavoritar')
  end

  scenario 'and unfavorite recipe' do 
    #setup 
    recipe = create(:recipe, title: 'Bolo de fubá')
    user = create(:user, email: 'any_user@bol.com')
    Favorite.create user: user, recipe: recipe

    #navigator 
    login_as user
    visit recipe_path recipe
    click_on 'Desfavoritar'

    #expect
    expect(page).to have_content('Removido dos favoritos com sucesso!')
  end

  scenario 'unfavorite a recipe and view another favorite recipe' do 
    #setup 
    recipe = create(:recipe, title: 'Bolo de fubá')
    recipe2 = create(:recipe, title: 'Coco ralado doce', 
                     cuisine: recipe.cuisine, recipe_type: recipe.recipe_type, author: recipe.author)
    user = create(:user, email: 'another_user@bol.com')
    Favorite.create user: user, recipe: recipe
    Favorite.create user: user, recipe: recipe2

    #navigator 
    login_as user
    visit recipe_path recipe
    click_on 'Desfavoritar'
    visit favorites_recipes_path

    #expect
    expect(page).to have_css('h1', text: recipe2.title)
    expect(page).to have_css('li', text: recipe2.author.email)
    expect(page).not_to have_css('h1', text: recipe.title)
  end

  scenario 'visit minhas receitas favoritas bu not logged' do 

    visit favorites_recipes_path

    expect(page).to have_current_path(new_user_session_path)
  end

end