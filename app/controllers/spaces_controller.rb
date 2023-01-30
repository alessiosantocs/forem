class SpacesController < ApplicationController
  before_action :authenticate_user!

  def show
    session[:space_id] = params[:id]
    redirect_to root_path(switched: true)
  end

end
