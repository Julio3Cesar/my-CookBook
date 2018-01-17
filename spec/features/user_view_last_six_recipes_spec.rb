require 'rails_helper'

feature 'user View the last 6 recipes' do
  scenario 'successfully' do 
    #setup
    user = User.new(email: 'user@gmail.com', password: '12345678')
    recipe_1 = create(:recipe, title: 'Bolo de fubá', author: user)
    recipe_2 = create(:recipe, title: 'Galinha assada', 
    author: user, cuisine: recipe_1.cuisine , recipe_type: recipe_1.recipe_type)
    recipe_3 = create(:recipe, title: 'Feijoada',
    author: user, cuisine: recipe_1.cuisine , recipe_type: recipe_1.recipe_type)
    recipe_4 = create(:recipe, title: 'Curau',
    author: user, cuisine: recipe_1.cuisine , recipe_type: recipe_1.recipe_type)
    recipe_5 = create(:recipe, title: 'Rato frito', 
    author: user, cuisine: recipe_1.cuisine , recipe_type: recipe_1.recipe_type)
    another_user = User.new(email: 'another_user@gmail.com', password: '12345678')
    recipe_6 = create(:recipe, title: 'Espeto de Grilo', 
    author: another_user, cuisine: recipe_1.cuisine , recipe_type: recipe_1.recipe_type)
    recipe_7 = create(:recipe, title: 'Farofa de porco', 
    author: another_user, cuisine: recipe_1.cuisine , recipe_type: recipe_1.recipe_type)

    #navigate
    login_as user
    visit root_path
    
    #expect 
    #1 not expect
    expect(page).not_to have_css('h1', text: recipe_1.title)
    #2
    expect(page).to have_css('h1', text: recipe_2.title)
    expect(page).to have_css('li', text: recipe_2.author.email)
    #3
    expect(page).to have_css('h1', text: recipe_3.title)
    expect(page).to have_css('li', text: recipe_3.author.email)
    #4
    expect(page).to have_css('h1', text: recipe_4.title)
    expect(page).to have_css('li', text: recipe_4.author.email)
    #5
    expect(page).to have_css('h1', text: recipe_5.title)
    expect(page).to have_css('li', text: recipe_5.author.email)
    #6
    expect(page).to have_css('h1', text: recipe_6.title)
    expect(page).to have_css('li', text: recipe_6.author.email)
    #7
    expect(page).to have_css('h1', text: recipe_7.title)
    expect(page).to have_css('li', text: recipe_7.author.email)
  end

  scenario 'click on button for view all' do 
    #setup
    user = User.new(email: 'user@gmail.com', password: '12345678')
    recipe_1 = create(:recipe, title: 'Bolo de fubá', author: user)
    recipe_2 = create(:recipe, title: 'Galinha assada', 
    author: user, cuisine: recipe_1.cuisine , recipe_type: recipe_1.recipe_type)
    recipe_3 = create(:recipe, title: 'Feijoada',
    author: user, cuisine: recipe_1.cuisine , recipe_type: recipe_1.recipe_type)
    recipe_4 = create(:recipe, title: 'Curau',
    author: user, cuisine: recipe_1.cuisine , recipe_type: recipe_1.recipe_type)
    recipe_5 = create(:recipe, title: 'Rato frito', 
    author: user, cuisine: recipe_1.cuisine , recipe_type: recipe_1.recipe_type)
    another_user = User.new(email: 'another_user@gmail.com', password: '12345678')
    recipe_6 = create(:recipe, title: 'Espeto de Grilo', 
    author: another_user, cuisine: recipe_1.cuisine , recipe_type: recipe_1.recipe_type)
    recipe_7 = create(:recipe, title: 'Farofa de porco', 
    author: another_user, cuisine: recipe_1.cuisine , recipe_type: recipe_1.recipe_type)

    #navigate
    login_as user
    visit root_path
    click_on 'Visualizar tudo'
    
    #expect 
    #1 not expect
    expect(page).to have_css('h1', text: recipe_1.title)
    expect(page).to have_css('li', text: recipe_1.author.email)
    #2
    expect(page).to have_css('h1', text: recipe_2.title)
    expect(page).to have_css('li', text: recipe_2.author.email)
    #3
    expect(page).to have_css('h1', text: recipe_3.title)
    expect(page).to have_css('li', text: recipe_3.author.email)
    #4
    expect(page).to have_css('h1', text: recipe_4.title)
    expect(page).to have_css('li', text: recipe_4.author.email)
    #5
    expect(page).to have_css('h1', text: recipe_5.title)
    expect(page).to have_css('li', text: recipe_5.author.email)
    #6
    expect(page).to have_css('h1', text: recipe_6.title)
    expect(page).to have_css('li', text: recipe_6.author.email)
    #7
    expect(page).to have_css('h1', text: recipe_7.title)
    expect(page).to have_css('li', text: recipe_7.author.email)
  end
end