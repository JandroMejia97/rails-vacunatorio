class SessionsController < ApplicationController
  include SessionsHelper
  skip_before_action :require_login, only: [:create, :login]
  layout 'auth'

  def login
    @user= User.new
  end

  def create
    session_params = params.permit(:email, :password)
    @user = User.find_by(email: session_params[:email])
    if !!@user
      if @user.login_attempts_count >= 10 && @user.updated_at < 2.hours.ago
        update_login_attempts_count(@user, 0)
      end
      if @user.login_attempts_count < 10
        if @user.authenticate(session_params[:password])
          update_login_attempts_count(@user, 0)
          session[:user_id] = @user.id
          session[:expires_at] = Time.now + 3.hours
          redirect_to root_path
        else
          update_login_attempts_count(@user, @user.login_attempts_count + 1)
          flash[:danger] = I18n.t('auth.login.wrong_password')
          redirect_to auth_login_path
        end
      else
        flash[:danger] = I18n.t('auth.login.too_many_attempts')
        redirect_to auth_login_path
      end
    else
      flash[:danger] = I18n.t('auth.login.wrong_email')
      redirect_to auth_login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = I18n.t('auth.logout.success')
    redirect_to auth_logout_path
  end

  private
  def update_login_attempts_count(user, login_attempts)
    user.update_attribute(:login_attempts_count, login_attempts)
  end
end
