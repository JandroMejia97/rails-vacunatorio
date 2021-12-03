module VaccinesHelper

    def get_quantity_of_vaccines_available(campaign)
        
        if has_role? :vacunador
            lost_turns = Turn.lost.where(campaign_id: campaign.id, vaccination_center_id: current_user.vaccination_center_id).count
            return lost_turns
        else
            assigned_turns = Turn.assigned.where(campaign_id: campaign.id).count
            return campaign.stock - assigned_turns
        end
    end

end
