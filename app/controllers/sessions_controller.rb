class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    unless @user.provider.nil?
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @user = User.find_by_email(user_params[:email])
      if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
        redirect_to root_url, notice: "Logged in!"
      else
        if @user.nil?
        @user = User.new(email:user_params[:email])
        @user.errors.add(:name, "Email or password is incorrect")
        render 'new'
        end
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end


