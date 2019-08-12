class CommentsController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        @comment = Comment.new(user_id: current_user.id, post_id: params[:post_id], body: comment_params[:body])
        if @comment.save
            redirect_to @user
        end
    end

    def edit
        @comment = Comment.find(params[:id])
    end

    def update
        @comment = Comment.find(params[:id])
        @comment.update(comment_params)
        redirect_to @comment.post.user
    end

    def comment_params
        params.require(:comment).permit!
    end
end
