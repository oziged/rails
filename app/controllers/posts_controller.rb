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
        unless post_params[:images].nil?
            post_params[:images].each do |post_image|
                test  = @post.images.new(data: post_image)
                p '*' * 100
                p test
                test.save
                p test.errors
                p '*' * 100
            end
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
        new_images = post_params[:images]
        # render plain: new_images.count
        @post = Post.find(params[:id])
        if @post.images.count + new_images.count > 5
            # flash[:error] = "12312313"
            redirect_to edit_user_post_path(@post), notice: '123123'
        else 
            @post.update(post_params.except(:images))
            post_params[:images].each do |post_image|
                @post.images.create(data: post_image)
            end
            redirect_to @post.user
        end
    end

    def post_params
        params.require(:post).permit!
    end

end

