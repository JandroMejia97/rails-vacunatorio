class AddColumnToRols < ActiveRecord::Migration[6.1]
  def change
    add_column :rols, :description, :string
  end
end
