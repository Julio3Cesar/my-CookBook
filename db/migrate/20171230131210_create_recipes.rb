class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :recipe_type
      t.references :cuisine, foreign_key: true
      t.string :difficulty
      t.integer :cook_time

      t.timestamps
    end
  end
end
