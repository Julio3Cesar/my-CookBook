class RecipeController < ApplicationController

  def show 
    @recipe = Recipe.find(params[:id])
  end  

  def new 
    @recipe = Recipe.new
  end

  def create 
    recipe = Recipe.new(recipe_params)
    if recipe.valid?
      recipe.save
      redirect_to recipe
    else
      @recipe = recipe
      render :new
    end
  end

  private 

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :difficulty, :cuisine_id, :cook_time, :ingredients, :method)
  end
end