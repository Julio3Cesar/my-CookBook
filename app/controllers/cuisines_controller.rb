class CuisinesController < ApplicationController
  before_action :find_cuisine, only: [:show]
  
  def show
    @recipes = Recipe.where(cuisine: params[:id])
    if @recipes.blank?
      flash.now[:notice] =  'Nenhuma receita encontrada para este tipo de cozinha'
    end
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new cuisine_params
    if @cuisine.save
      redirect_to @cuisine
    else
      render :new
    end
  end

  private 

  def find_cuisine
    @cuisine = Cuisine.find(params[:id])
  end

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end