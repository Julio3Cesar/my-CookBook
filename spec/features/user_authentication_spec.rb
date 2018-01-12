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
    expect(page).not_to have_content('Login')
    expect(page).to have_content("Bem-vindo #{user.email}")
    expect(page).to have_content('Logout')
  end 
end