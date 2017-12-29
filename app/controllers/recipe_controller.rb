class RecipeController < ApplicationController

  def show 
    @recipe = Recipe.find(params[:id])
  end  

  def new 
    @recipe = Recipe.new
  end

  def create 
    recipe = Recipe.create(recipe_params)
    # redirect_to '/'
    redirect_to recipe_path recipe.id 
  end

  private 

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type, :cuisine, :difficulty, :cook_time, :ingredients, :method)
  end
end