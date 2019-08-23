$(document).on 'turbolinks:load', ->
  App.comments = App.cable.subscriptions.create ({
    channel: "UserChannel",
    id: document.querySelector('[data-user-id]').getAttribute('data-user-id')
  }),

    connected: ->
      console.log('live');
      console.log(document.querySelector('[data-user-id]').getAttribute('data-user-id'))

    disconnected: ->

    received: (data) ->
      switch data.type
        when 'post'
          $('.posts').prepend(data.div)
        when 'comment'
          if (data.commentable_type == 'Comment')
            comment_div = $('[data-type=comment][data-id=' + data.commentable_id + ']')
            $(comment_div.next().next().next().next()).prepend(data.div)
          if (data.commentable_type == 'Post')
            post_comments_div = $('.post_comments[data-id=' + data.commentable_id + ']')
            post_comments_div.prepend(data.div)
        when 'comment_img_del'
          console.log('test')
          # modal_deactivate = a = document.querySelector("[href='#commentImage37']")
          # modal_deactivate.click()

