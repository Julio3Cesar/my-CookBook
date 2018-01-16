class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :recipe, uniqueness: { scope: :user, message: 'Receita já é favorita!' }
end
