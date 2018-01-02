class RecipeTypeController < ApplicationController
  def show 
    @recipe_type = RecipeType.find(params[:id])
    @recipes = Recipe.where(recipe_type_id: params[:id]).all
    if @recipes.blank?
      flash[:notice] =  'Nenhuma receita encontrada para este tipo de receitas'
    else
      flash[:notice] =  ''
    end
  end
end