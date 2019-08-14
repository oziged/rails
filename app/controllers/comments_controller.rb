class CommentsController < ApplicationController
    def create
        # render plain: [comment_params, params]
        @user = User.find(params[:user_id])
        @comment = Post.find(params[:post_id]).comments.new(user_id: current_user.id, body: comment_params[:body])
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
