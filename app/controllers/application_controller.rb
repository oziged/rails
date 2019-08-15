class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
      @current_user.update_attribute(:was_online, DateTime.now)
      @current_user
    else
      @current_user = nil 
    end
  end
end
