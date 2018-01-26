require 'rails_helper'

feature 'user visit my recipes' do
  scenario 'Successfully' do
    # setup
    recipe_1 = create :recipe, title: 'primeira'
    another_author = create :user, email: 'another_user@bol.com'
    recipe_2 = create :recipe, title: 'segunda', author: another_author,
                               recipe_type: recipe_1.recipe_type, cuisine: recipe_1.cuisine

    # navigate
    login_as recipe_1.author
    visit root_path
    click_on 'Minhas Receitas'

    # expect
    expect(page).not_to have_css('h1', text: recipe_2.title)
    expect(page).to have_css('h1', text: recipe_1.title)
    expect(page).to have_css('li', text: recipe_1.author.email)
  end

  scenario 'and view two recipes' do
    # setup
    recipe_1 = create :recipe, title: 'primeira'
    recipe_2 = create :recipe, title: 'segunda', author: recipe_1.author,
                               recipe_type: recipe_1.recipe_type, cuisine: recipe_1.cuisine
    another_author = create :user, email: 'another_user@bol.com'
    recipe_3 = create :recipe, title: 'terceira', author: another_author,
                               recipe_type: recipe_1.recipe_type, cuisine: recipe_1.cuisine

    # navigate
    login_as recipe_1.author
    visit root_path
    click_on 'Minhas Receitas'

    # expect
    expect(page).not_to have_css('h1', text: recipe_3.title)
    expect(page).to have_css('h1', text: recipe_1.title)
    expect(page).to have_css('li', text: recipe_1.author.email)
    expect(page).to have_css('h1', text: recipe_2.title)
    expect(page).to have_css('li', text: recipe_2.author.email)
  end

  scenario 'but not is author a recipe' do
    # setup
    recipe_1 = create :recipe, title: 'primeira'
    another_author = create :user, email: 'another_user@bol.com'

    # navigate
    login_as another_author
    visit root_path
    click_on 'Minhas Receitas'

    # expect
    expect(page).not_to have_css('h1', text: recipe_1.title)
    expect(page).to have_content('Você não possui receitas cadastradas!')
  end

  scenario 'if not logged' do
    # navigate
    visit root_path
    click_on 'Minhas Receitas'

    # expect
    expect(page).to have_current_path(new_user_session_path)
  end
end
