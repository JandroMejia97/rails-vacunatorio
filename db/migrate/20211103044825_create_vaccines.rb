class CreateVaccines < ActiveRecord::Migration[6.1]
  def change
    create_table :vaccines do |t|
      t.string :name, null: false
      t.integer :number_of_doses, default: 1
      t.integer :stock, default: 0
      t.belongs_to :campaign, foreign_key: true, null: false

      t.timestamps
    end
  end
end
