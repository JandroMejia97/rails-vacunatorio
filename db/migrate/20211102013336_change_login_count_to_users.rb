class ChangeLoginCountToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :logins_count, :login_attempts_count
  end
end
