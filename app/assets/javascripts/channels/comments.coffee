$(document).on 'turbolinks:load', ->
  App.comments = App.cable.subscriptions.create ({
    channel: "CommentsChannel",
    id: document.querySelector('[data-user-id]').getAttribute('data-user-id')
  }),

  connected: ->
    console.log('live');
    console.log(document.querySelector('[data-user-id]').getAttribute('data-user-id'))

  disconnected: ->
# Called when the subscription has been terminated by the server

  received: (data) ->
    console.log(data)
    if (data.commentable_type == 'Comment')
      comment_div = $('[data-type=comment][data-id=' + data.commentable_id + ']')
      console.log(comment_div)
      console.log(comment_div.next().next().next())
      $(comment_div.next().next().next().next()).prepend(data.div)
    if (data.commentable_type == 'Post')
      post_comments_div = $('.post_comments[data-id=' + data.commentable_id + ']')
      post_comments_div.prepend(data.div)
