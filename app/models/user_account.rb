class UserAccount
    include ActiveModel::Model
    include UsersHelper

    attr_accessor :email, :password
    validates :email, :presence => true
    validates :password, length: { minimum: 8 }
    validates_presence_of :password, :on => [:create, :update]
    validate :email_uniqueness?
end