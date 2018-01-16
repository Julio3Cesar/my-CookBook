require 'rails_helper'

feature 'User favorite recipe' do
  scenario 'successfully' do 
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

  scenario 'successfully' do 
    #setup 
    recipe = create(:recipe, title: 'Bolo de fubá')
    recipe2 = create(:recipe, title:'Bolo de maracujá Baiano',
                    cuisine: recipe.cuisine, recipe_type: recipe.recipe_type, 
                    author: recipe.author)
    recipe3 = create(:recipe, title:'Macarrão de seila com coco (Doce)',
                    cuisine: recipe.cuisine, 
                    recipe_type: recipe.recipe_type, author: recipe.author)
    user = User.create(email: 'user@bol.com', password: '12345678')

    #navigator 
    login_as user
    visit recipe_path recipe
    click_on 'Favoritar'
    visit recipe_path recipe2
    click_on 'Favoritar'
    click_on 'Minhas Receitas Favoritas'

    #expect
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.author.email)
    expect(page).to have_css('h1', text: recipe2.title)
    expect(page).to have_css('li', text: recipe2.author.email)
    expect(page).not_to have_css('h1', text: recipe3.title)
  end

  scenario 'successfully' do 
    #setup 
    recipe = create(:recipe, title: 'Bolo de fubá')

    #navigator 
    visit recipe_path recipe

    #expect
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_link('Favoritar')
    expect(page).not_to have_link('Desfavoritar')
  end
end