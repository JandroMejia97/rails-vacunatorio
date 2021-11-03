class CreateUserRols < ActiveRecord::Migration[6.1]
  def change
    create_table :users_roles, primary_key: [:user_id, :role_id] do |t|
      t.belongs_to :user
      t.belongs_to :role

      t.timestamps
    end
  end
end
