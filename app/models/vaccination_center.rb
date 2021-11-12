class VaccinationCenter < ApplicationRecord
    has_many :turns
    has_many :users
    
    validates :name, presence: true, length: { maximum: 50, minimum: 3 }
    validates :address, presence: true, length: { maximum: 100, minimum: 3 }
end
