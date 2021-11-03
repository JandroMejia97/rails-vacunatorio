class CreateUserRols < ActiveRecord::Migration[6.1]
  def change
    create_table :users_rols, primary_key: [:user_id, :rol_id] do |t|
      t.belongs_to :user
      t.belongs_to :rol

      t.timestamps
    end
  end
end
