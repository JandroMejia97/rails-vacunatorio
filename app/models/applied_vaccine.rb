class AppliedVaccine < ApplicationRecord
    belongs_to :vaccine
    has_one :turn

    validates :lot_number, presence: true, length: { maximum: 50, minimum: 3 }
    validates :applied_dose, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :vaccine_id, presence: true
end
