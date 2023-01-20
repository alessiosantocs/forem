module SetCurrentRequestDetails
  extend ActiveSupport::Concern

  included do |base|
    if base < ActionController::Base
      set_current_tenant_through_filter
      before_action :set_request_details
    end
  end

  def set_request_details
    Current.request_id = request.uuid
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
    Current.user = current_user

    # Account may already be set by the AccountMiddleware
    Current.space ||= space_from_domain || space_from_subdomain || space_from_param || space_from_session || fallback_account

    set_current_tenant(Current.space)
  end

  def space_from_domain
    # return unless Jumpstart::Multitenancy.domain?
    # Account.find_by(domain: request.domain)
  end

  def space_from_subdomain
    # return unless Jumpstart::Multitenancy.subdomain? && request.subdomains.size > 0
    # Account.find_by(subdomain: request.subdomains.first)
  end

  def space_from_session
    return unless user_signed_in? && (space_id = session[:space_id])
    current_user.spaces.find_by(id: space_id)
  end

  def space_from_param
    # return unless (space_id = params[:space_id].presence)
    # Space.find_by(id: space_id)
  end

  def fallback_account
    return unless user_signed_in?
    current_user.spaces.order(default: :asc).first
  end
end
