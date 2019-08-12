class UsersController < ApplicationController
  before_action :current_user, only: [:show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def search
    if params[:input]
      @users = make_search params[:input]
    else
      @users = User.all
    end
  end

  def show
    @online = online_status @user.was_online
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
        redirect_to @user, notice: 'User was successfully created.'
      else
        render 'new'
        # redirect_to signup_path
      end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
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
      temp_params = params.require(:user).permit!
      temp_params[:birth_date] = "#{temp_params['birth_date(1i)']}|#{temp_params['birth_date(2i)']}|#{temp_params['birth_date(3i)']}'"
      temp_params.delete('birth_date(1i)')
      temp_params.delete('birth_date(2i)')
      temp_params.delete('birth_date(3i)')
      temp_params
    end
end
