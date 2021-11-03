class Turn < ApplicationRecord
    enum status: { pedding: 0, assigned: 1, finished: 2, canceled: 3, lost: 4 }
    belongs_to :user
    belongs_to :campaign
    belongs_to :vaccination_center
    belongs_to :vaccine
    validates :user_id, presence: true
    validates :campaign_id, presence: true
    validates :vaccination_center_id, presence: true
    validates :status, inclusion: { in: Turn.statuses.keys }
    validate :validate_date?

    def validate_date?
        return unless date?
        begin
            if self.date.instance_of? String
                self.date = Date.strptime(date, "%Y-%m-%d") rescue nil
            end
        rescue ArgumentError
            errors.add(:date, "must be a valid date")
            return false
        end
        if date < Date.today
            errors.add(:date, I18n.t('validations.date.after', date: Date.today.strftime("%d/%m/%Y")))
            return false
        end
        return true
    end
end
