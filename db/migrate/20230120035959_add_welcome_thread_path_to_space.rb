class AddWelcomeThreadPathToSpace < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :welcome_thread_path, :string
  end
end
