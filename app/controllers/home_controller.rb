class HomeController < ApplicationController

  def index
    @recipes = Recipe.last(6)
    @most_favorites = []
    fav = Favorite.group(:recipe_id).limit(3).count
    fav.values.sort_by{|a| a}.reverse.each do |d|
      @most_favorites << Recipe.find(fav.key(d))
    end
  end
end