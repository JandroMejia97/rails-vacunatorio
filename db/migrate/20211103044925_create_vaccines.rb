class CreateVaccines < ActiveRecord::Migration[6.1]
  def change
    create_table :vaccines do |t|
      t.string :name
      t.integer :lot_number
      t.integer :doses_number
      t.integer :applied_dose

      t.timestamps
    end
  end
end
