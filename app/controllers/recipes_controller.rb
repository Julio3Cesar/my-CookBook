class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :find_recipe, only: [:show, :edit, :destroy, :update, :is_author, :favorite, :unfavorite, :share]
  before_action :is_author, only: [:edit, :update, :destroy, :update]
  
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
    @recipe.favorites.create(user: current_user)
    flash[:notice] = "Adicionado aos favoritos com sucesso!"
    redirect_to recipe_path @recipe 
  end
  
  def unfavorite
    Favorite.find_by(user: current_user, recipe: @recipe).destroy
    flash[:notice] = 'Removido dos favoritos com sucesso!'
    redirect_to recipe_path @recipe
  end

  def favorites
    @recipes = current_user.favorites_recipes
    if @recipes.empty?
      flash[:notice] = 'Nenhuma receita favorita!'
    end
  end

  def share
    email = params[:email]
    message = params[:message]
    RecipesMailer.share(email: email, message: message, recipe_id: @recipe.id).deliver_now
    
    flash[:notice] = "Receita enviada para #{email}"
    redirect_to recipe_path @recipe
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