class ValidateAddForeignKeyToArticle < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :articles, :spaces
  end
end