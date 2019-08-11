class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :online_status  

  def online_status str
    was_online = DateTime.parse(str).to_i
    now = DateTime.now.to_i
    offline = now - was_online
    if offline < 300
        'online'
    else 
      if offline < 3600
        "#{offline/60} минут назад"
      elsif offline < 86400
        "#{offline/3600} часов назад"
      else 
        "#{Time.at(was_online).to_s[0..-16]}"
      end
    end
end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
      @current_user.update(was_online: DateTime.now)
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
