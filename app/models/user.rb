class User < ApplicationRecord
    include UsersHelper
    include ActiveModel::Validations
    has_secure_password
    has_many :user_roles
    has_many :roles, :through => :user_roles
    belongs_to :vaccination_center, optional: true

    validates :vaccination_center_id, presence: false, allow_nil: true
    validates :email, :presence => true, uniqueness: { case_sensitive: false }
    validates :document_number, :presence => true, uniqueness: true, numericality: { only_integer: true, greater_than_or_equal_to: 10000 }
    validates :password, length: { minimum: 8 }, allow_blank: true
    validates :first_name, :presence => true, length: { minimum: 2 }
    validates :last_name, :presence => true, length: { minimum: 2 }
    validates :birthdate, :presence => true
    validates :comorbidity, :inclusion => { :in => [true, false] }
    validates_presence_of :password, :on => [:create]
    validate :validate_birthdate?, :document_number_uniqueness?, :email_uniqueness?

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
    end

end
