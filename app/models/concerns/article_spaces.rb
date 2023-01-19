module ArticleSpaces
  extend ActiveSupport::Concern

  included do
    belongs_to :space
    acts_as_tenant :space
  end

end
