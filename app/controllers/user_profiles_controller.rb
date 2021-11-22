class UserProfilesController < ApplicationController
    include SessionsHelper, RolesHelper
    skip_before_action :require_login, only: [:new, :create]
    layout 'auth'

    def modify
        $u = params[:user]
        @user = User.find_by(id: $u)
        render layout: 'application'
    end

    def update2
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
            redirect_to all_users_path
        else
            puts "Error: #{@user.errors.inspect}"
            flash[:danger] = I18n.t('base_text.error')
            render layout: 'application', :action => :modify
        end
    end

    def all_users
        @users = User.where.not(id: current_user.id)
        render layout: 'application'
    end

    def me
        @user = current_user
        render layout: 'application'
    end

    def edit
        @user_profile = current_user
        render layout: 'application'
    end

    def update
        @user_profile = current_user
        user_params = params.require(:user).permit(
            :first_name,
            :last_name,
            :document_number,
            :birthdate,
            :comorbidity
        )
        if @user_profile.update(user_params)
            flash[:success] = I18n.t('base_text.success')
            redirect_to me_path
        else
            puts "Error: #{@user_profile.errors.inspect}"
            flash[:danger] = I18n.t('base_text.error')
            render layout: 'application', :action => :edit
        end
    end

    def new
        # An instance of UserProfile is created just the
        # same as you would for any Active Record object.
        @user_profile = UserProfile.new

        if logged_in?
            if is_organization_member?
                render layout: 'application'
            else
                redirect_to root_path
            end
        end
    end
  
    def create
        # Again, an instance of UserProfile is created
        # just the same as you would for any Active
        # Record object.
        @user_profile = UserProfile.new(user_profile_params)
  
        # The valid? method is also called just the same
        # as for any Active Record object.
        if @user_profile.valid?
  
            # Instead of persisting the values to the
            # database, we're temporarily storing the
            # values in the session.
            session[:user_profile] = {
                'first_name' => @user_profile.first_name,
                'last_name' => @user_profile.last_name,
                'document_number' => @user_profile.document_number,
                'birthdate' => @user_profile.birthdate,
                'comorbidity' => @user_profile.comorbidity
            }

            redirect_to new_user_account_path
        else
            if logged_in?
                if is_organization_member?
                    render layout: 'application', template: 'user_profiles/new'
                else
                    redirect_to root_path
                end
            else
                render :new
            end
        end
    end
  
      private
  
      # The strong params work exactly as they would
      # for an Active Record object.
    def user_profile_params
        params.require(:user_profile).permit(
            :first_name,
            :last_name,
            :document_number,
            :birthdate,
            :comorbidity
        )
    end
end