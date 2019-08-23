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
      console.log('12321321')
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
          modal_deactivate = document.querySelector("[href='#commentImage#{data.comment_id}']")
          modal_img_div = document.querySelector("[data-target='#commentImageModal#{data.comment_id}'][data-toggle='modal']")
          if getComputedStyle(modal_img_div).height != 'auto'
            modal_deactivate.click()
          setTimeout ->
            modal_img_div.innerHTML = ''
          , 600
        when 'comment_update'
          comment_parent_block = document.querySelector(".post_comment[data-id='#{data.comment_id}']").parentNode
          comment_parent_block.style.opacity = 0
          setTimeout ->
            comment_parent_block.innerHTML = data.div.comment
            comment_parent_block.style.opacity = 1
          , 1000
        when 'comment_del'
          console.log(123)