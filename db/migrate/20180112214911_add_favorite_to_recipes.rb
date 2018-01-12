class AddFavoriteToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :favorite, :boolean
  end
end
