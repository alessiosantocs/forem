module Api
  module Admin
    module UsersController
      extend ActiveSupport::Concern

      def create
        user = nil
        # NOTE: We can add an inviting user here, e.g. User.invite!(current_user, user_params).
        if user_params[:password].present?
          user=User.create!(user_params)
        else
          user=User.invite!(user_params)
        end

        render json: user
      end

      def add_to_space
        if params[:user_id] == 'by_email'
          @user_to_add_to_space = User.find_by_email!(params.require(:email))
        else
          @user_to_add_to_space = User.find(params[:user_id])
        end

        Spaces::AddToSpaceWorker.perform_async(@user_to_add_to_space.id, params[:space_id])

        render json: {}
      end

      def banish
        if params[:user_id] == 'by_email'
          @user_to_banish = User.find_by_email!(params.require(:email))
        else
          @user_to_banish = User.find(params[:user_id])
        end
        Moderator::BanishUserWorker.perform_async(@user.id, @user_to_banish.id)

        render json: {}
      end

      def full_delete
        if params[:user_id] == 'by_email'
          @user_to_delete = User.find_by_email!(params.require(:email))
        else
          @user_to_delete = User.find(params[:user_id])
        end

        Moderator::DeleteUser.call(user: @user_to_delete)

        render json: {}
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
            confirmed_at: Time.now.utc,
            registered_at: Time.now.utc,
            _skip_add_to_default_space: params[:_skip_add_to_default_space],
          }.compact_blank
        else
          {
            email: params.require(:email),
            name: params[:name],
            username: params[:username] || params[:email],
            _skip_add_to_default_space: params[:_skip_add_to_default_space], # Will this work?
          }.compact_blank
        end
      end
    end
  end
end
