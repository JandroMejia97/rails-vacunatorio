class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :vaccination_center, null: true
  end
end
