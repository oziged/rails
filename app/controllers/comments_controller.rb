class CommentsController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        @comment = Comment.new(user_id: current_user.id, post_id: params[:post_id], body: comment_params[:body])
        if @comment.save
            redirect_to @user
        end
    end

    def comment_params
        params.require(:comment).permit!
    end
end
