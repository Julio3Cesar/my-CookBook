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

  def favorite 
    @recipes = Recipe.where(favorite: true)
    
  end

  def new_favorite
    recipe = Recipe.find params[:id]
    recipe.update(favorite: !recipe.favorite)
    if recipe.favorite
      flash[:notice] = 'Adicionado a lista de favoritos'
    else
      flash[:notice] = 'Removido da lista de favoritos'
    end
    redirect_to recipe_path recipe
  end

  private 

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :difficulty, :cuisine_id, :cook_time, :ingredients, :method)
  end
end