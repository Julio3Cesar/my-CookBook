class FavoritesController < ApplicationController

  def create 
    flash[:notice] = "Adicionado aos favoritos com sucesso!"
    r = Recipe.find(params[:id])
    r.favorites.create(user_id: current_user.id)
    redirect_to recipe_path r 
  end

  def index
    f = Favorite.where(user_id: current_user.id)
    @recipes = []
    f.each do |f|
      @recipes << Recipe.find(f.recipe_id)
    end
  end

end