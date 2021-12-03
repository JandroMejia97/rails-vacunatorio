class AppliedVaccinesController < ApplicationController

    def new
      @applied_vaccine= AppliedVaccine.new
      $turn= (params[:turn])
      end

    def create
      @applied_vaccine= AppliedVaccine.new(applied_vaccine_params)
      @applied_vaccine.campaign_id = turn.campaign_id
      if @applied_vaccine.save
        turn.applied_vaccine_id=@applied_vaccine.id
        turn.status=Turn.statuses[:finished]
        turn.save
        campaign=Campaign.find_by(id: @applied_vaccine.campaign_id)
        campaign.stock= campaign.stock - 1
        campaign.save
        if campaign.id == 1
          next_turn= Turn.new
          next_turn.status = Turn.statuses[:assigned]
          next_turn.user_id = turn.user_id
          next_turn.campaign_id = campaign.id
          next_turn.vaccination_center_id = turn.vaccination_center_id
          next_turn.date= Date.today + 15.days
          next_turn.save
        else
          if campaign.id == 3
            next_turn= Turn.new
            next_turn.status = Turn.statuses[:assigned]
            next_turn.user_id = turn.user_id
            next_turn.campaign_id = campaign.id
            next_turn.vaccination_center_id = turn.vaccination_center_id
            next_turn.date= Date.today + 1.year
            next_turn.save
          end
        end
        redirect_to pending_turns_path
      else
        render :new
      end
    end

    def applied_vaccine_params
      params.require(:applied_vaccine).permit(:lot_number, :applied_dose, :marca, :campaign_id)
    end

end