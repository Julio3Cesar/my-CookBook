require 'rails_helper'

feature 'User register cuisine' do
  scenario 'successfully' do

    visit new_cuisine_path
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brasileira')
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de cozinha')
  end

  scenario 'and must fill in name' do
    visit new_cuisine_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome da cozinha')
  end

  scenario 'User registers two equal cuisines' do
    #setup
    Cuisine.create(name: 'Brasileira')

    #navigator
    visit new_cuisine_path
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    #expect
    expect(page).to have_css('div.error', text: 'Cozinha já cadastrada!')
  end
end
