class CuisinesController < ApplicationController

  def show
    @cuisine = Cuisine.find(params[:id])
    @recipes = Recipe.where("cuisine_id =?",  params[:id]).all
    if @recipes.blank?
      flash[:notice] =  'Nenhuma receita encontrada para este tipo de cozinha'
    else
      flash[:notice] =  ''
    end
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    cuisine = Cuisine.new cuisine_params
    if cuisine.valid?
      cuisine.save
      redirect_to cuisine
    else
      @cuisine = cuisine
      render :new
    end
  end

  private 

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end