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

def make_search str
  search_params = str.split(' ')
  if search_params[1].nil?
    result = User.where(name: search_params[0])
    if result.length == 0
      result = User.where(surname: search_params[0])
    else 
      result
    end
  else
    result = User.where(name: search_params[0]).where(surname: search_params[1])
    if result.length == 0
      result = User.where(surname: search_params[0]).where(name: search_params[1])
    else
      result
    end   
  end
end
