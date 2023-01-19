module CurrentHelper
  def current_space
    Current.space
  end

  # def current_space_user
  #   @account_user ||= current_space.user_spaces.find_by(user: current_user)
  # end

  # def current_roles
  #   current_space_user.active_roles
  # end

  # def current_space_admin?
  #   !!current_space_user&.admin?
  # end

  # def other_accounts
  #   @_other_accounts ||= current_user.accounts.order(name: :asc).where.not(id: current_space.id)
  # end
end
