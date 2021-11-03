class AddColumnToCampaigns < ActiveRecord::Migration[6.1]
  def change
    add_column :campaigns, :description, :string
  end
end
