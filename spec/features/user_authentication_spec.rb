require 'rails_helper'

feature 'user authentication' do 
  scenario 'login sucess' do
    #setup 
    user = User.create(email: 'bob@gmail.com', password: '12345678')

    #navigate
    visit root_path
    click_on 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'

    #expect
    expect(page).not_to have_link('Login')
    expect(page).to have_content("Login efetuado com sucesso.")
    expect(page).to have_link('Logout')
  end 

  scenario 'logout sucess' do 
    #setup 
    user = User.create(email: 'bob@gmail.com', password: '12345678')

    #navigate
    login_as user
    visit root_path
    click_on 'Logout'

    #expect
    expect(page).to have_link('Login')
    expect(page).to have_content("Logout efetuado com sucesso.")
    expect(page).not_to have_link('Logout')
  end
end