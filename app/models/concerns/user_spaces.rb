module UserSpaces
  extend ActiveSupport::Concern

  included do
    has_many :user_spaces, dependent: :destroy
    has_many :spaces, through: :user_spaces

    attr_accessor :_skip_add_to_default_space

    # All new users should automatically have a space
    after_create_commit :add_to_default_space, unless: :_skip_add_to_default_space
  end

  def add_space(space)
    begin
      spaces << space
    rescue ActiveRecord::RecordInvalid => e
      puts "Already added"
    end
  end

  def remove_space(space)
    user_space = user_spaces.find_by(space_id: space.id)
    if user_space
      user_space.delete
    else
      puts "Space not found"
    end
  end

  def spaces_count
    spaces.count
  end


  private

  # Private: Add to default space on creation 
  def add_to_default_space
    default_space = Space.find_by(default: true)
    add_space(default_space)
  end
end
