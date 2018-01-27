class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :favorites
  has_many :users_favored, through: :favorites, source: :user

  validates :title, :recipe_type, :cuisine,
            :difficulty, :cook_time, :ingredients, :method,
            presence:
            { message: 'Você deve informar todos os dados da receita' }

  has_attached_file :photo, styles:
                    { medium: '300x300>', thumb: '100x100>' },
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  def favorited?(user)
    users_favored.include? user
  end

  def author?(user)
    return user.recipes.include? self if user
    false
  end
end
