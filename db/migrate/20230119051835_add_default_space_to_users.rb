class AddDefaultSpaceToUsers < ActiveRecord::Migration[7.0]
  def up
    default_space = Space.find_or_initialize_by(default: true)
    default_space.update!(name: "Default Space") if default_space.new_record?
    default_space.users = User.all
  end
end
