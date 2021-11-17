class Vaccine < ApplicationRecord
    belongs_to :campaign
    has_many :applied_vaccines

    validates :name, presence: true, length: { maximum: 50, minimum: 3 }
    validates :number_of_doses, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
    validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :campaign_id, presence: true, allow_blank: false
end
