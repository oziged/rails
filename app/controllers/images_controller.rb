class ImagesController < ApplicationController
    def destroy
        @image = Image.find(params[:id])
        @image.destroy
        ActionCable.server.broadcast "user_channel_#{@image.post.user.id}",
        type: 'post_img_delete',
        image_id: @image.id,
        post_id: @image.post_id
    end
end
