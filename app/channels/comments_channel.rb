class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comments_channel"
    p '*' * 100
    p params.inspect
    p '*' * 100
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
