class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :destroy, :update]

  def search
    @term = params[:term]
    if @term
      @recipes = Recipe.where(title: params[:term])      
    else
      @recipes = Recipe.all
    end
    
  end

  def show 
  end  

  def new 
    @recipe = Recipe.new 
  end

  def create 
    @recipe = Recipe.new(recipe_params)
    @recipe.author = current_user
    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy 
    redirect_to root_path
  end

  private 

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :difficulty, :cuisine_id, :cook_time, :ingredients, :method)
  end
end