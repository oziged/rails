class CommentsController < ApplicationController
    def create
        @user = current_user
        @comment = current_user.comments.new(comment_params)
        if @comment.save
            post_author = @comment.get_post_author
            if post_author == current_user
                redirect_to root_path
            else
                redirect_to post_author
            end
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

    def destroy_image
        @comment = Comment.find(params[:id])
        @comment.image.remove!
        redirect_to @comment.get_post_author
    end

    def comment_params
            params.require(:comment).permit!
    end
end
