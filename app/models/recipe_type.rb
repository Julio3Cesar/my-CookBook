class RecipeType < ApplicationRecord
  validates :name, presence: { message: 'Você deve informar o nome do tipo de receita' }
  validates :name, uniqueness: { message: 'Tipo da receita já cadastrada!' }

  def to_s
    name
  end
end
