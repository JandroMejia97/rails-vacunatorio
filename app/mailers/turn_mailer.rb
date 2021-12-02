class TurnMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.turn_mailer.assign_turn.subject
  #
  def assign_turn
    @turn = params[:turn]
    mail to: @turn.user.email, subject: I18n.t('turn_mailer.subject', date: @turn.date.strftime('%d/%m/%Y'))
  end
end
