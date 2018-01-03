class RecipeTypesController < ApplicationController
  def show 
    @recipe_type = RecipeType.find(params[:id])
    @recipes = Recipe.where("recipe_type_id =?", params[:id]).all
    if @recipes.blank?
      flash[:notice] =  'Nenhuma receita encontrada para este tipo de receitas'
    else
      flash[:notice] =  ''
    end
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    recipe_type = RecipeType.new(recipe_type_params)

    if recipe_type.valid?
      recipe_type.save
      redirect_to recipe_type
    else
      @recipe_type = recipe_type
      render :new
    end
  end
  
  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end