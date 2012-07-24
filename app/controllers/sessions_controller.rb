class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    self.current_user = User.find_or_create_from_auth(auth)
    redirect_back_or_to_root
  end

  def destroy
    sign_out_user
    redirect_back_or_to_root
  end
end
