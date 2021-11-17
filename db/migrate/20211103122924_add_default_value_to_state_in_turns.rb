class AddDefaultValueToStateInTurns < ActiveRecord::Migration[6.1]
  def change
    change_column :turns, :status, :integer, :default => 0
  end
end
