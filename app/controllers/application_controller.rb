class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_cuisine_aside
  before_action :find_recipe_type_aside


  private 

  def find_cuisine_aside
    @cuisines = Cuisine.all
  end

  def find_recipe_type_aside
    @recipe_types = RecipeType.all
  end

  def require_login
    unless current_user == @recipe.author
      flash[:alert] = "Acesso negado!"
      redirect_to root_path
    end
  end
end
