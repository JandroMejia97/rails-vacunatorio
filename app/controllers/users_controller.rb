class UsersController < ApplicationController
    include SessionsHelper

    def index
      @users = User.where.not(id: current_user.id)
    end

  def edit
    @user = User.find_by(id: params[:id])
  end


def update
    @user = User.find_by(id: params[:id])
    user_role= UserRole.find_by(user_id: @user.id)
    role= Role.find_by(id: params[:user][:roles])
    if user_role
      user_role.update(role_id: role.id)
    else
      user_role= UserRole.new(user_id: @user.id, role_id: role.id)
      user_role.save
    end
    if @user.update(user_params)
        flash[:success] = I18n.t('base_text.success')
        redirect_to users_path
    else
        puts "Error: #{@user.errors.inspect}"
        flash[:danger] = I18n.t('base_text.error')
        render layout: 'application', :action => :modify
    end
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
      params.require(:user).permit(:first_name, :last_name, :document_number,:email, :birthdate,:comorbidity,:vaccination_center_id)
    end

end
