class Turn < ApplicationRecord
    enum status: { pendding: 0, assigned: 1, finished: 2, canceled: 3, lost: 4 }
    belongs_to :user
    belongs_to :campaign
    belongs_to :vaccination_center
    has_one :applied_vaccine
    has_one :vaccine, :through => :applied_vaccine

    validates :user_id, presence: true
    validates :campaign_id, presence: true
    validates :vaccination_center_id, presence: true
    validates_presence_of :applied_vaccine_id, :on => :update
    validates :status, inclusion: { in: Turn.statuses.keys }
    validate :validate_date?, :has_turn_in_campaign?

    scope :lost, -> { where("status = ? AND date < ?", Turn.statuses[:assigned], Date.today)}
    scope :assigned, -> { where("status = ? AND date >= ?", Turn.statuses[:assigned], Date.today) }

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
      if Turn.where("user_id = ? AND campaign_id = ? AND (status = ? OR status = ?)", user_id, campaign_id, Turn.statuses[:pendding], Turn.statuses[:assigned]).where.not(id: id).exists?
          errors.add(:campaign_id, I18n.t('validations.turn.has_turn_in_campaign'))
          return false
      else
          return true
      end
  end

    def self.search(search, current_user)
      turns = Turn.joins(:user, :campaign).where(date: Date.today, status: Turn.statuses[:assigned], vaccination_center_id: current_user.vaccination_center_id)
      if search
        user = User.find_by(document_number: search)
        if user #Si encuentra el usuario con DNI ingresado
          temp_turns = turns.find_all { |turn| turn.user_id == user.id }
          if temp_turns.length >0 #Si encuentra un turno pedido por el usuario 
            return [temp_turns, { :success => true }]
          else #encuentra el dni, pero no tiene turno
            return [turns, { :error => I18n.t('turn.no_turno') }]
          end
        else #no hay dni en el sistema
          return [turns, { :error => I18n.t('turn.no_dni') }]
        end 
      else
        return [turns, { :success => true }]
      end
    end


      def self.search_status(search_status,turns)
        if search_status
          turns= turns.where(status: search_status)
          if turns #encuentra turnos con ese status
            return [turns, {:succes => true }]
          else #no encuentra turnos
            eturn [turns, { :error => I18n.t('turn.no_date') }]
          end
        else
          return [turns, {:success => true}]
        end
        return [turns, { :success => true }]
      end


      def self.search_date(search_date, turns)
        if search_date
          turns= turns.where(date: search_date)
          if turns #Si encuentra turnos con esa fecha
            return [turns, { :success => true }]
          else #si no encuentra turnos
            return [turns, { :error => I18n.t('turn.no_date') }]
          end
        else
          return [turns, {:success => true}]
        end
        return [turns, { :success => true }]
      end
end
