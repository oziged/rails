class BroadcastUserChannelJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @comment = args[0]
    ActionCable.server.broadcast "user_channel_#{@comment.get_post_author.id}",
     type: 'comment_update',
     div: {comment: (ApplicationController.render partial: 'comments/comment', locals: {comment: @comment})},
     comment_id: @comment.id
  end
end
