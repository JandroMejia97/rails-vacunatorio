class Vaccine < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50, minimum: 3 }
    validates :lot_number, presence: true, length: { maximum: 50, minimum: 3 }
    validates :doses_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :applied_dose, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
