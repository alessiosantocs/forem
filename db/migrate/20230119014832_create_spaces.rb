class CreateSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :spaces do |t|
      t.string :name
      t.string :description
      t.boolean :default
      t.boolean :limit_post_creation_to_admins, default: false

      t.timestamps
    end
  end
end
