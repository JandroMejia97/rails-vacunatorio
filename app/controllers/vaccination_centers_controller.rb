class VaccinationCentersController < ApplicationController


    def index
        @vaccination_center=VaccinationCenter.all
    end

    # DELETE /vaccination_centers/1
    def destroy
        set_vaccination_center
        @vaccination_center.destroy
        respond_to do |format|
          format.html { redirect_to vaccination_centers_path, notice: "El centro de vacunacion se elimino satisfactoriamente." }
          format.json { head :no_content }
        end
    end

    def modify
    
    end


    private
        def set_vaccination_center
            @vaccination_center = VaccinationCenter.find(params[:id])
        end
end
