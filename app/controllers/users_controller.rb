class UsersController < ApplicationController
  before_action :current_user, only: [:show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if params[:input]
      @users = make_search params[:input]
    else
      @users = User.all
    end
  end

  def show
    @post = @user.posts.new
  end

  def new
    @link = signup_path
    @user = User.new
  end

  def edit
    @link = user_path
    if current_user.id != @user.id
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        @user.update(was_online: DateTime.now)
        redirect_to @user, notice: 'User was successfully created.'
      else
        @link = signup_path
        render 'new'
      end
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    reset_session
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit!
    end
end
