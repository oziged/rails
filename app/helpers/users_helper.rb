module UsersHelper

  def can_current_user_change? (item)
    current_user && current_user.id == item[:user_id] ? true : false
  end

end