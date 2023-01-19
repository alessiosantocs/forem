class AddForeignKeyToArticle < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :articles, :spaces, on_delete: :cascade, validate: false
  end
end