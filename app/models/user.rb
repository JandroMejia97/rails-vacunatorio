class User < ApplicationRecord
    has_secure_password

    validates :email, :presence => true, uniqueness: { case_sensitive: false }
    validates :document_number, :presence => true, uniqueness: true, numericality: { only_integer: true, greater_than_or_equal_to: 10000 }
    validates :password, :presence => true, length: { minimum: 8 }
    validates :first_name, :presence => true, length: { minimum: 2 }
    validates :last_name, :presence => true, length: { minimum: 2 }
    validates :birthdate, :presence => true, comparison: { greater_than: Proc.new { Date.today - 100.years } }
    validates :comorbidity, :presence => true

end
