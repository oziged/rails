class BroadcastUserChannelJob < ApplicationJob
  queue_as :default

  def perform(*args)
    if args[0].class.to_s == 'Post'
      @post = args[0]
      ActionCable.server.broadcast "user_channel_#{@post.user_id}",
      type: 'post_update',
      div: {post: (ApplicationController.render partial: 'posts/post_main', locals: {post: @post})},
      post_id: @post.id
    end
    if args[0].class.to_s == 'Comment'
      @comment = args[0]
      ActionCable.server.broadcast "user_channel_#{@comment.get_post_author.id}",
      type: 'comment_update',
      div: {comment: (ApplicationController.render partial: 'comments/comment_main', locals: {comment: @comment})},
      comment_id: @comment.id
    end
  end
end
