class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :login]
  layout 'auth/base'

  def login
    @user= User.new
  end

def create
  session_params = params.permit(:email, :password)
  @user = User.find_by(email: session_params[:email])
  if !!@user
    if ((@user.logins_count < 10) || (@user.updated_at < 1.hour.ago))
      if @user.authenticate(session_params[:password])
        log=0
        @user.update_attribute(:logins_count,log)
        session[:user_id] = @user.id
        session[:expires_at]= Time.now + 3.hours
        redirect_to user_path(@user)
      else
        log=@user.logins_count+1
        @user.update_attribute(:logins_count,log)
        flash[:notice]="La contraseña es incorrecta, vuelva a intentarlo."
        redirect_to auth_login_path
      end
    else
      flash[:notice]= "Su cuenta ha sido bloqueada luego de 10 intentos fallidos de inicio de sesión. Se reactivará dentro de 24 horas."
      redirect_to auth_login_path
    end
  else
    flash[:notice]="El correo ingresado no es válido, por favor ingrese un correo previamente registrado."
    redirect_to auth_login_path
  end
end

def destroy
  session[:user_id] = nil
  flash[:notice] = "Usted cerró sesión!"
  redirect_to auth_logout_path
end
end

