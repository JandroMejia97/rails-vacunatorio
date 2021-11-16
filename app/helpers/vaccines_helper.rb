module VaccinesHelper

    def get_quantity_of_vaccines_available(vaccines)
        
        turns = Turn.where(:campaign => vaccines).where.not(status: [Turn.statuses[:pendding], Turn.statuses[:finished]])
        if has_role? :vacunador
            assigned = 0
            assigned = turns.where(vaccination_center_id: current_user.vaccination_center_id, :status => Turn.statuses[:assigned]).count
            return turns.count - assigned
        else
            total = 0
            for vaccine in vaccines do
                total += vaccine.stock
            end
            return total - turns.count
        end
    end
end
