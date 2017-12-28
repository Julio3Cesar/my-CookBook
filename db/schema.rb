# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20171228170702) do
=======
ActiveRecord::Schema.define(version: 20171228161726) do
>>>>>>> c03f30ae975d0a37a1b06ee825ddd65307542978

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.string "recipe_type"
    t.string "cuisine"
    t.string "difficulty"
    t.integer "cook_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
<<<<<<< HEAD
    t.text "ingredients"
    t.text "method"
=======
>>>>>>> c03f30ae975d0a37a1b06ee825ddd65307542978
  end

end
