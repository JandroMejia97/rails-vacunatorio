class ChangeLotNumberTypeToVaccines < ActiveRecord::Migration[6.1]
  def change
    change_column :vaccines, :lot_number, :string
  end
end
