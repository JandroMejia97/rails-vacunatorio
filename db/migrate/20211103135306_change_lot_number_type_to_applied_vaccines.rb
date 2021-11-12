class ChangeLotNumberTypeToAppliedVaccines < ActiveRecord::Migration[6.1]
  def change
    change_column :applied_vaccines, :lot_number, :string
  end
end
