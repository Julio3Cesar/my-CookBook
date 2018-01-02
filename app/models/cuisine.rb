class Cuisine < ApplicationRecord
  
  validates :name, presence: {message: 'Você deve informar o nome da cozinha'}

  def to_s
    name
  end
end
