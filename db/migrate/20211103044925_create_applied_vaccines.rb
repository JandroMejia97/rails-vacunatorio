class CreateAppliedVaccines < ActiveRecord::Migration[6.1]
  def change
    create_table :applied_vaccines do |t|
      t.integer :lot_number
      t.integer :applied_dose
      t.belongs_to :vaccine, foreign_key: true, null: false

      t.timestamps
    end
  end
end
