class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_access, only: [:edit, :update, :destroy]

  def index
    if params[:input]
      @users = User.search_by_fullname(params[:input])
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
    @user.avatar = params[:file] # Assign a file like this, or
    # render plain: user_params.inspect
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
    params[:id].nil? ? @user = current_user : @user = User.find(params[:id])
    redirect_to login_path if current_user.nil? && params[:id].nil?
  end

  def check_access
    if current_user.nil?
      redirect_to login_path
    elsif @user != current_user
      redirect_to current_user
    end
  end

  def user_params
    params.require(:user).permit!
  end
end
