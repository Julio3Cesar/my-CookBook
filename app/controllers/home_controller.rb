class HomeController < ApplicationController

  def index
    @recipes = Recipe.all
    @recipes_types = RecipeType.all
    @cuisines = Cuisine.all
  end
end