class ChangeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :applied_vaccines, :description, :marca
  end
end
