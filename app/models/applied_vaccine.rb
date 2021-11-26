class AppliedVaccine < ApplicationRecord
    belongs_to :campaign
    has_one :turn

    validates :lot_number, presence: true, length: { maximum: 50, minimum: 3 }
    validates :applied_dose, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :marca, presence: true, length: { maximum: 50, minimum: 3 }
    validates :campaign_id, presence: true
end
