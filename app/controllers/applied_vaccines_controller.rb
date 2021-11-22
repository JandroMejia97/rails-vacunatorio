class AppliedVaccinesController < ApplicationController

    def new
      @applied_vaccine= AppliedVaccine.new
      $turn= (params[:turn])
      end

    def create
      @applied_vaccine= AppliedVaccine.new(applied_vaccine_params)
      if @applied_vaccine.save
        turn= Turn.find_by(id: $turn)
        id=@applied_vaccine.id
        turn.applied_vaccine_id=id
        turn.status=Turn.statuses[:finished]
        turn.save
        vaccine=Vaccine.find_by(id: @applied_vaccine.vaccine_id)
        vaccine.stock= vaccine.stock - 1
        vaccine.save
        redirect_to pending_turns_path
      else
        render :new
      end
    end

    def applied_vaccine_params
      params.require(:applied_vaccine).permit(:lot_number, :applied_dose, :vaccine_id)
    end

end