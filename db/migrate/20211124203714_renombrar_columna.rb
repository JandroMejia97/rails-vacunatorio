class RenombrarColumna < ActiveRecord::Migration[6.1]
  def change
    rename_column :applied_vaccines, :vaccine_id, :campaign_id
  end
end
