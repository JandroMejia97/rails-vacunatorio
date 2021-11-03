class VaccinationCenter < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50, minimum: 3 }
    validates :address, presence: true, length: { maximum: 100, minimum: 3 }
end
