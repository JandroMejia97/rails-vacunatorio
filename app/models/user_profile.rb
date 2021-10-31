class UserProfile
    include ActiveModel::Model

    attr_accessor :first_name, :last_name, :document_number, :birthdate, :comorbidity
    validates :first_name, :presence => true, length: { minimum: 2 }
    validates :last_name, :presence => true, length: { minimum: 2 }
    validates :document_number, :presence => true, numericality: { only_integer: true, greater_than_or_equal_to: 10000 }
    validates :birthdate, :presence => true
    validate :validate_birthdate?, :document_number_uniqueness?
    validates :comorbidity, :inclusion => { :in => [true, false] }

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

    def document_number_uniqueness?
        if User.where(document_number: document_number).exists?
            errors.add(:document_number, I18n.t('validations.document_number.uniqueness'))
        end
    end

end
