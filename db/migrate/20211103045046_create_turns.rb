class CreateTurns < ActiveRecord::Migration[6.1]
  def change
    create_table :turns do |t|
      t.date :date
      t.string :status
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :campaign, foreign_key: true, null: false
      t.belongs_to :vaccination_center, foreign_key: true, null: false
      t.belongs_to :applied_vaccine, index: { unique: true }, foreign_key: true, null: true

      t.timestamps
    end
  end
end
