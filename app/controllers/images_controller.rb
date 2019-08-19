class ImagesController < ApplicationController
    def destroy
        @image = Image.find(params[:id])
        @image.destroy
        if request.referrer.include? 'edit'
            redirect_to edit_user_post_path(user_id: @image.post.user.id, id: @image.post.id)
        else 
            redirect_to @image.post.user
        end
    end
end
