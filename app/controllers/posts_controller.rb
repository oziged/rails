class PostsController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        @post = @user.posts.new(post_params.except(:images))
        @post.save
        #
        # respond_to do |format|
        #     if @post.save
        #         format.js { render :action => "create" }
        #     else
        #         format.js { render :action => "create_error" }
        #     end
        # end
        urls = []

        post_params[:images].each do |post_image|
            test  = @post.post_images.new(data: post_image)
            p '*' * 100
            p test
            test.save
            p test.errors
            p '*' * 100

        end
        render plain: post_params[:images]
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

