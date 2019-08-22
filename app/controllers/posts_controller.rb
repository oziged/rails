class PostsController < ApplicationController
  before_action :check_post_change_access, only: [:edit, :update, :destroy]
  before_action :user_email_confirmed, only: [:create, :edit, :update, :destroy]

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(post_params.except(:images))
    if @post.save
      ActionCable.server.broadcast "user_channel_#{@post.user.id}",
      type: 'post',
      div: (render partial: 'posts/post', locals: {post: @post})
      flash[:success] = 'Post created'
    else
      flash[:error] = 'Title & Body can\'t be blank'
    end
    # redirect_to root_path

    #
    # respond_to do |format|
    #     if @post.save
    #         format.js { render :action => "create" }
    #     else
    #         format.js { render :action => "create_error" }
    #     end
    # end
    #
    urls = []
    unless post_params[:images].nil?
      post_params[:images].each do |post_image|
        @post.images.create(data: post_image)
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
  end

  def update
    new_images = post_params[:images]
    @post = Post.find(params[:id])
    if new_images.nil?
      @post.update(post_params.except(:images))
      flash[:success] = 'Post updated'
      redirect_to @post.user
    elsif @post.images.count + new_images.count > 5
      flash[:error] = 'Max count of images > 5'
      redirect_to edit_user_post_path(@post)
    else
      @post.update(post_params.except(:images))
      post_params[:images].each do |post_image|
        @post.images.create(data: post_image)
      end
      flash[:success] = 'Post updated'
      redirect_to @post.user
    end
  end

  def post_params
    params.require(:post).permit!
  end

  def check_post_change_access
    if current_user.nil?
      redirect_to login_path
    elsif Post.find(params[:id]).user != current_user
      redirect_to current_user
    end
  end

end

