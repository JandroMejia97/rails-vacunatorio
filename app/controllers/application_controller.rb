class ApplicationController < ActionController::Base
    include SessionsHelper
    before_action :require_login
end
