class RecipesController < ApplicationController
  # before_action :authenticate_user!, only: [:edit]
  before_action :find_recipe, only: [:show, :edit, :destroy, :update, :is_author]
  before_action :is_author, only: [:edit, :update]
  
  def search
    @term = params[:term]
    if @term
      @recipes = Recipe.where(title: params[:term])      
    else
      @recipes = Recipe.all
    end
  end
  
  def index
    @recipes = Recipe.all
  end

  def show 
    if current_user
      if current_user.recipes
        @is_favorite = current_user.recipes.include? @recipe
      end
    end
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
    recipe = Recipe.find(params[:id])
    if recipe.favorites.create(user: current_user)
      flash[:notice] = "Adicionado aos favoritos com sucesso!"
    else
      flash[:notice] = 'recipe.favorites.errors'
    end
    redirect_to recipe_path recipe 
  end

  def favorites
    @recipes = current_user.recipes
  end

  private 

  def is_author
    unless current_user == @recipe.author
      redirect_to root_path
    end
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :difficulty, :cuisine_id, :cook_time, :ingredients, :method)
  end
end