class PostsController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        @post = @user.posts.new(post_params)
        @post.save
        redirect_to @user
    end

    def destroy
        @user = User.find(params[:user_id])
        @user.posts.find(params[:id]).destroy
        redirect_to @user
    end

    def post_params
        params.require(:post).permit!
    end
end

