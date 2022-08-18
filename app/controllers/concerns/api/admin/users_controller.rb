module Api
  module Admin
    module UsersController
      extend ActiveSupport::Concern

      def create
        # NOTE: We can add an inviting user here, e.g. User.invite!(current_user, user_params).
        if user_params[:password].present?
          User.create!(user_params)
        else
          User.invite!(user_params)
        end

        head :ok
      end

      private

      # Given that we expect creators to use tools (e.g. their existing SSO,
      # Zapier, etc) to post to this endpoint I wanted to keep the param
      # structure as simple and flat as possible, hence slightly more manual
      # param handling.
      #
      # NOTE: username is required for the validations on User to succeed.
      def user_params
        if params[:password].present?
          {
            email: params.require(:email),
            name: params[:name],
            username: params[:username] || params[:email],
            password: params[:password],
            password_confirmation: params[:password],
            confirmed_at: Time.now.utc
          }.compact_blank
        else
          {
            email: params.require(:email),
            name: params[:name],
            username: params[:username] || params[:email]
          }.compact_blank
        end
      end
    end
  end
end
