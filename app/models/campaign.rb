class Campaign < ApplicationRecord
    has_many :turns
    has_many :vaccines
    validates :name, presence: true, length: { maximum: 80, minimum: 3 }
    validates :description, presence: true, length: { maximum: 500, minimum: 3 }
    validates :start_date, presence: true
    validate :validate_end_date?

    def validate_end_date?
        return unless start_date? && end_date?
        begin
            if self.start_date.instance_of? String
                self.start_date = Date.strptime(start_date, "%Y-%m-%d") rescue nil
            end
            if self.end_date.instance_of? String
                self.end_date = Date.strptime(end_date, "%Y-%m-%d") rescue nil
            end
        rescue ArgumentError
            errors.add(:date, "must be a valid date")
            return false
        end
        errors.add(:end_date, I18n.t('validations.date.after', date: start_date.strftime("%d/%m/%Y"))) if end_date < start_date
    end
            
end
