class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_channel_#{params[:id]}"
  end

  def unsubscribed
  end
end
