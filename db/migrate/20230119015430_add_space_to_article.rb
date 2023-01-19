class AddSpaceToArticle < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :articles, :space, null: true, index: {algorithm: :concurrently}
  end
end