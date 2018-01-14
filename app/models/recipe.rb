class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :author, class_name: "User", foreign_key: 'user_id', optional: true
  has_many :favorites
  has_many :users, through: :favorites

  validates_presence_of :title, :recipe_type, :cuisine,
                        :difficulty, :cook_time, :ingredients, :method,
                        message: "Você deve informar todos os dados da receita"

end
