class HomeController < ApplicationController

  def index
    @recipes = Recipe.last(6)
  end
end