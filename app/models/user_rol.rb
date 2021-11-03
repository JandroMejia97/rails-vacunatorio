require 'composite_primary_keys'
class UserRol < ApplicationRecord
  self.table_name = 'users_rols'
  belongs_to :rol
  belongs_to :user
end
