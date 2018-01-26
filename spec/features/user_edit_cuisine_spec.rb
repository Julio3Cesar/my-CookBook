require 'rails_helper'

feature 'User update cuisine' do
  scenario 'Successfully' do
    # setup
    cuisine = Cuisine.create(name: 'Brasileira')

    # navigate
    visit edit_cuisine_path cuisine
    fill_in 'Nome', with: 'Arabe'
    click_on 'Enviar'

    # expect
    expect(page).not_to have_css('h1', text: cuisine.name)
    expect(page).to have_css('h1', text: 'Arabe')
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de cozinha')
  end
end
