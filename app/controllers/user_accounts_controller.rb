class UserAccountsController < ApplicationController
    include SessionsHelper
    skip_before_action :require_login, only: [:new, :create]
    layout 'auth'

    def new
        @user_account = UserAccount.new
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
            User.create!(full_params)
    
            # Upon successful completion of the form we need to
            # clean up the session.
            session.delete('user_profile')
    
            redirect_to root_path
        else
            render :new
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