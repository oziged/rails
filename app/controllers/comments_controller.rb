class CommentsController < ApplicationController
    def create
        @user = current_user
        @comment = current_user.comments.new(comment_params)
        if @comment.save
            redirect_to @comment.get_post_author
        end
    end

    def edit
        @comment = Comment.find(params[:id])
    end

    def update
        @comment = Comment.find(params[:id])
        @comment.update(comment_params)
        redirect_to @comment.user
    end

    def comment_params
        params.require(:comment).permit!
    end
end
