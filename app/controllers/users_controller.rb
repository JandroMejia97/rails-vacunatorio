class UsersController < ApplicationController
  include SessionsHelper, RolesHelper

  def index
    @users = User.where.not(id: current_user.id)
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    user_role = UserRole.find_by(user_id: @user.id)
    role = Role.find_by(id: params[:user][:roles])
    if user_role
      user_role.update(role_id: role.id)
    else
      user_role = UserRole.new(user_id: @user.id, role_id: role.id)
      user_role.save
    end
    if @user.update(user_params)
      flash[:success] = I18n.t("base_text.success")
      redirect_to users_path
    else
      flash[:danger] = I18n.t("base_text.error")
      render layout: "application", :action => :modify
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = Rails.application.credentials.default_password.to_s
    vaccinator_role = Role.find_by(name: "VACUNADOR")

    if vaccinator_role.id == params[:user][:roles].to_i && params[:user][:vaccination_center_id].empty?
      flash[:danger] = I18n.t("user.create.vaccinator_require_vaccination_center")
      render :new
    else
     if @user.save
       citizen = Role.find_by(name: "CIUDADANO")
       user_role = nil
       if has_role?(:vacunador) || !params[:user][:roles].present?
         user_role = UserRole.new(user_id: @user.id, role_id: citizen.id)
       else
         user_role = UserRole.new(user_id: @user.id, role_id: params[:user][:roles])
       end
       user_role.save

       @token = @user.signed_id(purpose: :set_password)
       UserMailer.with(user: @user, token: @token, role: user_role.role).register.deliver_now
       flash[:success] = I18n.t("base_text.success")
       redirect_to users_path
     else
       flash[:danger] = I18n.t("base_text.error")
       render :new
     end
    end

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :document_number, :email, :birthdate, :comorbidity, :vaccination_center_id)
  end
end
