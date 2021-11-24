class AgregarStock < ActiveRecord::Migration[6.1]
  def change
    add_column :campaigns, :stock, :integer
  end
end
