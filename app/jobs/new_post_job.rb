class NewPostJob < ApplicationJob
  queue_as :default

  def perform(post)
    p '#' * 100
    p post.inspect
    p '#' * 100
    ActionCable.server.broadcast "user_channel_#{post.user.id}",
                                 type: 'post_create',
                                 div: (ApplicationController.render partial: 'posts/post_full', locals: {post: post})
  end
end
