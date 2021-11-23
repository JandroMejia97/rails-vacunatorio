class UsersController < ApplicationController
    include SessionsHelper
    
    def index
      @users = User.where.not(id: current_user.id)
    end
    
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path
      else
        render :new
      end
    end
  
    private 
    def user_params
      params.require(:user).permit(:email, :password, :document_number)
    end

end
