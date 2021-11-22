class UsersController < ApplicationController
    include SessionsHelper

    def index
      @users = User.where.not(id: current_user.id)
      render layout: 'application'
  end

  def modify
    $u = params[:user]
    @user = User.find_by(id: $u)
    render layout: 'application'
end

def update
    @user = User.find_by(id: $u)
    user_params = params.require(:user).permit(
        :first_name,
        :last_name,
        :document_number,
        :email,
        :birthdate,
        :comorbidity,
        :vaccination_center_id
    )
    if @user.update(user_params)
        flash[:success] = I18n.t('base_text.success')
        redirect_to index_path
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
      params.require(:user).permit(:email, :password, :document_number)
    end

end
