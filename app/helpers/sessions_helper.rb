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
            flash[:warning] = I18n.t('auth.session_expired')
            session[:user_id] = nil
            redirect_to auth_login_path
        else
            session[:expires_at]= Time.now + 3.hours
        end
    end
end
