class Cuisine < ApplicationRecord
  validates :name, presence: { message: 'Você deve informar o nome da cozinha' }
  validates :name, uniqueness: { message: 'Cozinha já cadastrada!' }

  def to_s
    name
  end
end
