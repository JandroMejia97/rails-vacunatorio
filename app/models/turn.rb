class Turn < ApplicationRecord
    enum status: { pedding: 0, assigned: 1, finished: 2, canceled: 3, lost: 4 }
    belongs_to :user
    belongs_to :campaign
    belongs_to :vaccination_center
    belongs_to :vaccine, optional: true
    validates :user_id, presence: true
    validates :campaign_id, presence: true
    validates :vaccination_center_id, presence: true
    validates_presence_of :vaccine, :on => :update
    validates :status, inclusion: { in: Turn.statuses.keys }
    validate :validate_date?, :has_turn_in_campaign?

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

    def has_turn_in_campaign?
        return unless campaign_id
        if Turn.where("user_id = ? AND campaign_id = ? AND (status = ? OR status = ?)", user_id, campaign_id, Turn.statuses[:pedding], Turn.statuses[:assigned]).exists?
            errors.add(:campaign_id, I18n.t('validations.turn.has_turn_in_campaign'))
            return false
        else
            return true
        end
    end

    def self.search(search)
        if search
          u= User.find_by(document_number: search)
          if u #Si encuentra el usuario con DNI ingresado
            t= Turn.find_by(user_id: u.id, status: "assigned", date: Date.today.strftime("%d/%m/%Y")  )
            if t #Si encuentra un turno pedido por el usuario 
              self.where(user_id: t)
              return [@turns, { :success => true }]
            else
              return [nil, { :error => I18n.t('turn.no_turno') }]
            end
          else
            return [nil, { :error => I18n.t('turn.no_dni') }]
          end 
        else
          @turns= Turn.all
        end
        return [@turns, { :success => true }]
      end
end
