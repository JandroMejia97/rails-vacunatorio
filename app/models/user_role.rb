require 'composite_primary_keys'
class UserRole < ApplicationRecord
  self.table_name = 'users_roles'
  belongs_to :role
  belongs_to :user
end
