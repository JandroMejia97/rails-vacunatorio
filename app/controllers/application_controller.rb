class ApplicationController < ActionController::Base
    include SessionsHelper
    before_action :require_login, :session_expires

    def _sidebar
        @user = current_user
    end
end
