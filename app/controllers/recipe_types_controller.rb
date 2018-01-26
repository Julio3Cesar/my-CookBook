class RecipeTypesController < ApplicationController
  before_action :find_recipe_type, only: [:show]

  def show
    @recipes = Recipe.where(recipe_type_id: params[:id])
    flash.now[:notice] = 'Nenhuma receita encontrada para este tipo de receitas' if @recipes.blank?
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)
    @recipe_type.save ? redirect_to(@recipe_type) : render(:new)
  end

  private

  def find_recipe_type
    @recipe_type = RecipeType.find(params[:id])
  end

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end
