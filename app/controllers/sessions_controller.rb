class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    self.current_user = User.find_or_create_from_auth(auth)
    flash[:notice] = "Hello #{current_user.name}"
    redirect_to root_path
  end

  def destroy
    sign_out_user
    redirect_to root_path
  end
end
