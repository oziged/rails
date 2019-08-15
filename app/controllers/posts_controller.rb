class PostsController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        @post = @user.posts.new(post_params)
        @post.save

        respond_to do |format|
            if @post.save
                format.js { render :action => "create" }
            else
                format.js { render :action => "create_error" }
            end
        end
    end

    def show

    end

    def destroy
        @user = User.find(params[:user_id])
        @user.posts.find(params[:id]).destroy
        redirect_to @user
    end

    def edit
        @post = Post.find(params[:id])
        # render plain: @post.inspect
    end

    def update
        @post = Post.find(params[:id])
        @post.update(post_params)
        redirect_to @post.user
    end

    def post_params
        params.require(:post).permit!
    end
end

