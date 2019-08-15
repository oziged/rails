class LikesController < ApplicationController
  def create
    like = current_user.likes.create(likeable_type: like_params[:likeable_type], likeable_id: like_params[:likeable_id])
    redirect_to like.get_post_author
  end

  def destroy
    like = Like.find(params[:id])
    user = like.get_post_author
    like.destroy
    redirect_to user
  end

  private

  def like_params
    params.require(:like).permit!
  end
end
