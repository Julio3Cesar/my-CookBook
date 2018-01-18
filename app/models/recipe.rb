class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :author, class_name: "User", foreign_key: 'user_id'
  has_many :favorites
  has_many :users_favored, through: :favorites, source: :user

  validates_presence_of :title, :recipe_type, :cuisine,
                        :difficulty, :cook_time, :ingredients, :method,
                        message: "Você deve informar todos os dados da receita"

  def favorited? user
    users_favored.include? user
  end

  def author? user
    return user.recipes.include? self if user
    false
  end
end
