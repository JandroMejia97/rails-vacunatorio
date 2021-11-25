class AddColumnToAppliedVaccines < ActiveRecord::Migration[6.1]
  def change
    add_column :applied_vaccines, :description, :string
  end
end
