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
        session[:expires_at] < Time.now
        redirect_to auth_login_path
    end
end
