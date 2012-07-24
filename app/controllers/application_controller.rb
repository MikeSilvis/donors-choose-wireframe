class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  helper_method :current_user

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def sign_out_user
    session[:user_id] = nil
  end

  def authenticate_user
    unless current_user
      flash[:notice] = "You must sign in to perform this action"
      redirect_back_or_to_root
    end
  end

  def redirect_back_or_to_root
    request.env["HTTP_REFERER"] ||= request.env['omniauth.origin'] || root_url
    redirect_to :back
  end
end
