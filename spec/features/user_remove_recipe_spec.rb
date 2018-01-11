require 'rails_helper'

feature 'User remove recipe' do 
  scenario 'remove successfully' do 
    #setup
    main_type = RecipeType.create(name: 'Prato Principal')
    arabian_cuisine = Cuisine.create(name: 'Arabe')
    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                          cuisine: arabian_cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    visit root_path
    click_on recipe.title
    click_on 'Remover'

    expect(page).not_to have_content(recipe.title)
  end
end