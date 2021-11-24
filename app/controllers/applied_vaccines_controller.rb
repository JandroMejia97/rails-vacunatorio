class AppliedVaccinesController < ApplicationController

    def new
      @applied_vaccine= AppliedVaccine.new
      $turn= (params[:turn])
      end

    def create
      @applied_vaccine= AppliedVaccine.new(applied_vaccine_params)
      turn= Turn.find_by(id: $turn) 
      @applied_vaccine.campaign_id = Campaign.find_by(id: turn.campaign_id).id
      if @applied_vaccine.save
        turn.applied_vaccine_id=@applied_vaccine.id
        turn.status=Turn.statuses[:finished]
        turn.save
        campaign=Campaign.find_by(id: @applied_vaccine.campaign_id)
        campaign.stock= campaign.stock - 1
        campaign.save
        if campaign.id == 1
          turno= Turn.new
          turno.status = Turn.statuses[:assigned]
          turno.user_id = turn.user_id
          turno.campaign_id = campaign.id
          turno.vaccination_center_id = turn.vaccination_center_id
          turno.date= Date.today + 15.days
          turno.save
        else
          if campaign.id == 3
            turno= Turn.new
            turno.status = Turn.statuses[:assigned]
            turno.user_id = turn.user_id
            turno.campaign_id = campaign.id
            turno.vaccination_center_id = turn.vaccination_center_id
            turno.date= Date.today + 1.year
            turno.save
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