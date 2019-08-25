$(document).on 'turbolinks:load', ->
  App.comments = App.cable.subscriptions.create ({
    channel: "UserChannel",
    id: document.querySelector('[data-user-id]').getAttribute('data-user-id')
  }),

    connected: ->
      console.log('live');

    disconnected: ->

    received: (data) ->
      switch data.type
        when 'post_create'
          $('.posts').prepend(data.div)
        when 'post_update'
          post = document.querySelector(".post_main_#{data.post_id}")
          post_top_block = post.querySelector('.post_top_block')
          post.style.opacity = 0
          setTimeout -> 
            post.innerHTML = data.div.post
            post.style.opacity = 1
          , 1000
        when 'post_delete'
          post = document.querySelector("[data-type='post'][data-id='#{data.post_id}'")
          post.remove()
        when 'post_img_delete'
          img = document.querySelector("[data-target='#postImage#{data.image_id}']")
          img.remove()
          post_images_count = document.querySelector("#images#{data.post_id}").children.length
          post_images_toggle = document.querySelector("[href='#images#{data.post_id}'][data-toggle='collapse']")
          if !post_images_count
            post_images_toggle.remove()
        when 'comment_create'
          console.log('comment_create')
          if (data.commentable_type == 'Comment')
            comment_div = $('[data-type=comment][data-id=' + data.commentable_id + ']')
            $(".subcomments_#{data.commentable_id}").prepend(data.div);
          if (data.commentable_type == 'Post')
            post_comments_div = $('.post_comments[data-id=' + data.commentable_id + ']')
            post_comments_div.prepend(data.div)
        when 'comment_img_delete'
          modal_deactivate = document.querySelector("[href='#commentImage#{data.comment_id}']")
          modal_img_div = document.querySelector("[data-target='#commentImageModal#{data.comment_id}'][data-toggle='modal']")
          link_to_modal_img_div = document.querySelector("[href='#commentImage#{data.comment_id}']")
          if getComputedStyle(modal_img_div).height != 'auto'
            modal_deactivate.click()
          setTimeout ->
            modal_img_div.innerHTML = ''
            link_to_modal_img_div.parentNode.remove()
          , 600
        when 'comment_update'
          comment = document.querySelector(".comment_main_#{data.comment_id}")
          comment.style.opacity = 0
          setTimeout ->
            comment.innerHTML = data.div.comment
            comment.style.opacity = 1
          , 1000
        when 'comment_delete'
          comment = document.querySelector(".comment_full_#{data.comment_id}")
          comment.style.opacity = 0
          setTimeout -> 
            comment.remove()
          , 1000