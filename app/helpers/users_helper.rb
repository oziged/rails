module UsersHelper

  def can_current_user_change? (item)
    current_user && current_user.id == item[:user_id]
  end

  def get_user_id
    if params[:id].nil?
      return current_user.id
    else
      params[:id]
    end
  end


  def online_status user
    was_online = DateTime.parse(user.was_online).to_i
    now = DateTime.now.to_i
    offline = now - was_online
    if offline < 300
      'online'
    elsif
      offline < 3600
      "#{offline/60} minutes ago"
    elsif offline < 86400
      "#{offline/3600} hours ago"
    else
      "#{Time.at(was_online).strftime("%d/%m/%Y")}"
    end
  end
end