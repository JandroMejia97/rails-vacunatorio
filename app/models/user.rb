class User < ApplicationRecord
    has_secure_password

    validates :email, :presence => true, uniqueness: { case_sensitive: false }
    validates :password, length: { minimum: 8 }
    validates_presence_of :password, :on => [:create, :update]

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
