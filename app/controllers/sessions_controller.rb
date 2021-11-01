class SessionsController < ApplicationController
  include SessionsHelper
  skip_before_action :require_login, only: [:create, :new]
  layout 'auth/base'

  def login
    @user= User.new
  end

  def create
    session_params = params.permit(:email, :password)
    @user = User.find_by(email: session_params[:email])
    if !!@user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:notice] = "Login is invalid!"
      render action: 'login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been signed out!"
    redirect_to new_session_path
  end
end
