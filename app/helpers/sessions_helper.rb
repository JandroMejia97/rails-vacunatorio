module SessionsHelper
    def logged_in?
        !!session[:user_id]
    end

    def require_login
        redirect_to auth_login_path unless session.include? :user_id
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if !!session[:user_id]
    end
    def session_expires
        if logged_in? && session[:expires_at] < Time.now
            flash[:notice]= "Su sesión ha expirado. Por favor ingrese nuevamente"
            session[:user_id] = nil
            redirect_to auth_login_path
        else
            session[:expires_at]= Time.now + 5.minutes
        end
    end
end
