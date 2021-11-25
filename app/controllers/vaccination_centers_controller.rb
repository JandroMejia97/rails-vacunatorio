class VaccinationCentersController < ApplicationController
    include VaccinationCentersHelper

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

    def edit
        set_vaccination_center
    end

    # PATCH/PUT /vaccination_centers/1 or /vaccination_centers/1.json
    def update
        set_vaccination_center
        respond_to do |format|
            if name_uniqueness?(@vaccination_center.name) 
                if @vaccination_center.update(vaccination_center_params)
                    format.html { redirect_to vaccination_centers_path, notice: "El centro de vacunacion se modifico satisfactoriamente" }
                    format.json { render :show, status: :ok, location: @vaccination_center }
                else
                    format.html { render :edit, status: :unprocessable_entity }
                    format.json { render json: @vaccine.errors, status: :unprocessable_entity }
                end
            else
                format.html { redirect_to vaccination_centers_path, notice: "El nombre del centro de vacunacion no debe repetirse en el sistema" }
            end

        end
    end


    private
        def set_vaccination_center
            @vaccination_center = VaccinationCenter.find(params[:id])
        end

        def vaccination_center_params
            params.require(:vaccination_center).permit(:name, :address)
        end
end
