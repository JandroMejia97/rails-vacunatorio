class UserAccountsController < ApplicationController
    include SessionsHelper, RolsHelper
    skip_before_action :require_login, only: [:new, :create]
    layout 'auth'

    def new
        @user_account = UserAccount.new
        
        if logged_in?
            if is_organization_member?
                render layout: 'application'
            else
                redirect_to root_path
            end
        end
    end

    def create
        @user_account = UserAccount.new(user_account_params)
  
        if @user_account.valid?
            # The values from the previous form step need to be
            # retrieved from the session store.
            full_params = user_account_params.merge(
                first_name: session['user_profile']['first_name'],
                last_name: session['user_profile']['last_name'],
                document_number: session['user_profile']['document_number'],
                birthdate: session['user_profile']['birthdate'],
                comorbidity: session['user_profile']['comorbidity']
            )
    
            # Here we finally carry out the ultimate objective:
            # creating a User record in the database.
            @user = User.create!(full_params)
            # Upon successful completion of the form we need to
            # clean up the session.
            session.delete('user_profile')

            if !logged_in?
                session[:user_id] = @user.id
                session[:expires_at] = Time.now + 3.hours
                flash[:success] = I18n.t('auth.sign_in.success')
                redirect_to root_path
            else
                flash[:success] = I18n.t('add_user.second_step.success')
                redirect_to turns_url
            end
    
        else
            if logged_in?
                if is_organization_member?
                    render layout: 'application', template: 'user_accounts/new'
                else
                    redirect_to root_path
                end
            else
                render :new
            end
        end
    end

    private

    def user_account_params
        params.require(:user_account).permit(
            :email,
            :password
        )
    end
end