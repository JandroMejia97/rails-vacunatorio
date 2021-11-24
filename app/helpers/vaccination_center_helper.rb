module VaccinationCenterHelper

    def name_uniqueness?(namevac)
        result= VaccinationCenter.all.where(name: namevac).length
        if result == 0
            return true
        else
            return false
        end
    end


end
