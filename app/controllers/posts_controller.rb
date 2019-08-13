class PostsController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        @post = @user.posts.new(post_params)
        # @post.save
        if @post.save
            redirect_to @user
        else
            
        render

        end
        #     render(:template=> 'users/show')
        # end

        # respond_to do |format|
        #     format.js {}
        # end
        # render plain: @post.errors.inspect
        # render( :template=> 'users/show' )
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

