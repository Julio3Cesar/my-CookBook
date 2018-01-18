require 'rails_helper'

feature 'user_send_recipe_to_friend_spec' do
  scenario 'succesffuly' do
    recipe = create(:recipe, title: 'Feijoada de Frango')

    visit recipe_path recipe
    fill_in 'Email', with: 'amigo@email.com'
    fill_in 'Mensagem', with: 'Essa receita é muito legal'
    
    expect(RecipesMailer).to receive(:share).with(email: 'amigo@email.com',
                                                  message: 'Essa receita é muito legal',
                                                  recipe_id: recipe.id).and_call_original
                                                  
    click_on 'Enviar'
    
    expect(page).to have_content 'Receita enviada para amigo@email.com'
    expect(current_path).to eq recipe_path(recipe)
  end
end
