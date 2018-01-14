FactoryBot.define do
  factory :recipe  do
    title 'Bolo de cenoura'
    recipe_type
    cuisine 
    difficulty 'Médio'
    cook_time 50
    ingredients 'Farinha, açucar, cenoura'
    add_attribute(:method) {'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes'}
    author {create(:user)}
  end
end
