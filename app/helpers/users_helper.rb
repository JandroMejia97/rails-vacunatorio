module UsersHelper
    def validate_birthdate?
        return unless birthdate.to_time.present?

        begin
            self.birthdate = Date.strptime(birthdate, "%Y-%m-%d") rescue nil
        rescue ArgumentError
            errors.add(:birthdate, "is not a valid date")
            return false
        end
        date_message_format = "%d/%m/%Y"
        if self.birthdate.before?(Date.new(1900, 1, 1))
            errors.add(:birthdate, I18n.t('validations.date.after', date: Date.new(1900, 1, 1).strftime(date_message_format)))
        elsif self.birthdate.after?(Date.today - 6.years)
            errors.add(:birthdate, I18n.t('validations.date.before', date: (Date.today - 6.years).strftime(date_message_format)))
        end
    end
end
