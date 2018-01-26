class CuisinesController < ApplicationController
  before_action :find_cuisine, only: %i[show edit update]

  def show
    @recipes = Recipe.where(cuisine: params[:id])
    flash.now[:notice] = 'Nenhuma receita encontrada para este tipo de cozinha' if @recipes.blank?
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new cuisine_params
    @cuisine.save ? redirect_to(@cuisine) : render(:new)
  end

  def edit; end

  def update
    @cuisine.update(cuisine_params) ? redirect_to(@cuisine) : render(edit_cuisine_path(@cuisine))
  end

  private

  def find_cuisine
    @cuisine = Cuisine.find(params[:id])
  end

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end
