module UsersHelper
    def validate_birthdate?
        return unless birthdate.to_time.present?
        
        begin
            if self.birthdate.instance_of? String
                self.birthdate = Date.strptime(birthdate, "%Y-%m-%d") rescue nil 
            end
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

    def email_uniqueness?
        results = User.where('lower(email) = ?', email.downcase)
        if self.try(:id).presence && self.try(:id).present?
            results = results.where.not(id: id)
        end
        puts "results: #{results.inspect}"
        if results.exists?
            errors.add(:email, I18n.t('validations.email.uniqueness'))
            return false
        end
        return true
    end

    def document_number_uniqueness?
        results = User.where(document_number: document_number)
        if self.try(:id).presence && self.try(:id).present?
            results = results.where.not(id: id)
        end
        puts "results: #{results.inspect}"
        if results.exists?
            errors.add(:document_number, I18n.t('validations.document_number.uniqueness'))
            return false
        end
        return true
    end
end
