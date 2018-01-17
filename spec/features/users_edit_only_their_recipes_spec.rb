require 'rails_helper'

feature 'Users edit only their recipes' do
  scenario 'Successfully' do
    #Setup
    user = create :user, email: 'bol@bol.com'
    recipe = create(:recipe, title: 'Feijoada', difficulty: 'Difícil',
                          ingredients: 'Feijao, paio, carne seca',
                          method: 'Cozinhar o feijao e refogar com as carnes já preparadas',
                          cook_time: 90, author: user)

    #navigator
    login_as user
    visit edit_recipe_path recipe
    fill_in 'Título', with: 'Bolo de cenoura'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
  end

  scenario 'User attempts to edit a recipe that is not his' do
    #Setup
    user = create :user, email: 'bol@bol.com'
    user_2 = create :user, email: 'youhull@bol.com'
    recipe = create(:recipe, title: 'Feijoada', difficulty: 'Difícil',
                          ingredients: 'Feijao, paio, carne seca',
                          method: 'Cozinhar o feijao e refogar com as carnes já preparadas',
                          cook_time: 90, author: user_2)

    #navigator
    login_as user
    visit recipe_path recipe
    


    expect(page).to have_css('h1', text: 'Feijoada')
    expect(page).not_to have_content('Editar')
  end

  scenario 'user not logged, not see button edit' do
    #Setup
    recipe = create(:recipe, title: 'Feijoada')

    #navigator
    visit recipe_path recipe


    expect(page).to have_css('h1', text: 'Feijoada')
    expect(page).not_to have_link('Editar')
  end

  scenario 'user logged but not author, not see button edit' do
    #Setup
    user = create :user, email: 'youhull@bol.com'
    another_user = create :user
    recipe = create(:recipe, title: 'Feijoada', author: another_user)

    #navigator
    login_as user
    visit recipe_path recipe

    #expect
    expect(page).to have_css('h1', text: 'Feijoada')
    expect(page).not_to have_link('Editar')
  end

  scenario 'User LOGGED accesses route edit, but does not author the recipe' do
    #Setup
    user = create :user, email: 'user@bol.com'
    user_2 = create :user, email: 'youhull@bol.com'
    recipe = create(:recipe, title: 'Feijoada', difficulty: 'Difícil',
                          ingredients: 'Feijao, paio, carne seca',
                          method: 'Cozinhar o feijao e refogar com as carnes já preparadas',
                          cook_time: 90, author: user_2)

    #navigator
    login_as user
    visit edit_recipe_path recipe

    expect(page).to have_current_path(root_path)
  end

  scenario 'User NOT logged accesses route edit, but does not author the recipe' do
    #Setup
    user = create :user, email: 'youhull@bol.com'
    recipe = create(:recipe, title: 'Feijoada', difficulty: 'Difícil',
                          ingredients: 'Feijao, paio, carne seca',
                          method: 'Cozinhar o feijao e refogar com as carnes já preparadas',
                          cook_time: 90, author: user)

    #navigator
    visit edit_recipe_path recipe


    expect(page).to have_current_path(root_path)
  end
end