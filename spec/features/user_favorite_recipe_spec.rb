require 'rails_helper'

feature 'User favorite recipe' do
  scenario 'successfully' do 
    #setup 
    recipe = create(:recipe, title: 'Bolo de fubá', favorite: false)
    recipe2 = create(:recipe, title:'Bolo de maracujá Baiano',
                    cuisine: recipe.cuisine, recipe_type: recipe.recipe_type, 
                    author: recipe.author, favorite: false)
    recipe3 = create(:recipe, title:'Macarrão de seila com coco (Doce)',
                    cuisine: recipe.cuisine, 
                    recipe_type: recipe.recipe_type, author: recipe.author, favorite: false)
    user = User.new(email: 'user@gmail.com', password: '12345678')

    #navigator 
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
    click_on recipe.title
    click_on 'Adicionar aos favoritos'
    click_on 'Minhas Receitas'
    click_on recipe2.title
    click_on 'Adicionar aos favoritos'
    click_on 'Minhas Receitas Favoritas'

    #expect
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.author.email)
    expect(page).to have_css('h1', text: recipe2.title)
    expect(page).to have_css('li', text: recipe2.author.email)
    expect(page).not_to have_css('h1', text: recipe3.title)
  end
end