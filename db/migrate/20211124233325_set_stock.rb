class SetStock < ActiveRecord::Migration[6.1]
  def self.up
    campaigns= Campaign.all
    campaigns.each do |campaign|
      campaign.stock = 0
      campaign.vaccines.each do |vaccine|
        campaign.stock += vaccine.stock
      end
      campaign.save
    end
  end
end
