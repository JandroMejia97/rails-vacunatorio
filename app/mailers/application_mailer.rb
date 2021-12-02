class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.mailer_from
  layout 'mailer'
end
