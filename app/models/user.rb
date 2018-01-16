class User < ApplicationRecord
  # has_many :recipes, inverse_of: "author"
  has_many :favorites
  has_many :recipes, through: :favorites

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
