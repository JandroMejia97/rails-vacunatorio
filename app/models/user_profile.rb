class UserProfile
    include ActiveModel::Model
    include ActiveModel::Validations
    include UsersHelper

    attr_accessor :first_name, :last_name, :document_number, :birthdate, :comorbidity
    validates :first_name, :presence => true, length: { minimum: 2 }
    validates :last_name, :presence => true, length: { minimum: 2 }
    validates :document_number, :presence => true, numericality: { only_integer: true, greater_than_or_equal_to: 10000 }
    validates :birthdate, :presence => true
    validate :validate_birthdate?, :document_number_uniqueness?
    validates_presence_of :comorbidity, :in => [true, false]

end
