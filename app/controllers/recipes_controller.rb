class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :my, :favorites]
  before_action :find_recipe, only: [:show, :edit, :destroy, :update, :is_author, :favorite, :unfavorite, :share]
  before_action :require_login, only: [:edit, :update, :destroy]
  
  def search
    @term = params[:term]
    @term ? @recipes = Recipe.where("title LIKE ? OR ingredients LIKE ?", "%#{@term}%", "%#{@term}%") : @recipes = Recipe.all
  end
  
  def index
    @recipes = Recipe.all
  end

  def show 
  end  

  def new 
    @recipe = Recipe.new 
  end

  def create 
    @recipe = Recipe.new(recipe_params)
    @recipe.author = current_user
    @recipe.save ? redirect_to(@recipe) : render(:new)
  end

  def edit
  end

  def update
    @recipe.update(recipe_params) ? redirect_to(@recipe) : render(:edit)
  end

  def destroy
    redirect_to(root_path) if @recipe.destroy
  end

  def favorite
    Favorite.create(user: current_user, recipe: @recipe)
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
    flash[:notice] = 'Nenhuma receita favorita!' if @recipes.empty?
  end

  def share
    email = params[:email]
    message = params[:message]
    if RecipesMailer.share(email: email, message: message, recipe_id: @recipe.id).deliver_now
      flash[:notice] = "Receita enviada para #{email}"
    else
      flash[:alert] = "Problemas ao enviar a receita para #{email}"
    end
    redirect_to recipe_path @recipe
  end

  def my 
    @recipes = Recipe.where author: current_user
    flash[:notice] = 'Você não possui receitas cadastradas!' if @recipes.empty?
  end

  private 

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :difficulty, :cuisine_id, :cook_time, :ingredients, :method)
  end
end