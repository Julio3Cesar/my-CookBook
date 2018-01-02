class RecipeType < ApplicationRecord
  
  validates :name, presence: {message: 'Você deve informar o nome do tipo de receita'}
  
  def to_s
    name
  end
end
