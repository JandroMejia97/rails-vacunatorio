class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.register.subject
  #
  def register
    @user = params[:user]
    @token = params[:token]
    role = params[:role].name
    @full_name = "#{@user.first_name} #{@user.last_name}"
    mail to: @user.email, subject: I18n.t('user_mailer.register.subject', role: role, name: @full_name)
  end
end
