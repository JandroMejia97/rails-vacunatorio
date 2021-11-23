class VaccinationCenterController < ApplicationController
    def index
        @vaccination_center=VaccinationCenter.all
    end
end
