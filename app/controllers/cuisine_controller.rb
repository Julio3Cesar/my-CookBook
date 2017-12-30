class CuisineController < ApplicationController

  def show
    @cuisine = Cuisine.find(params[:id])
    @recipes = Recipe.find_by_sql("SELECT  'recipes'.* FROM 'recipes' WHERE 'recipes'.'cuisine_id' = #{params[:id]}")
    if @recipes.blank?
      flash[:notice] =  'Nenhuma receita encontrada para este tipo de cozinha'
    else
      flash[:notice] =  ''
    end
  end

end